/**
 * LIBER TEMPORIS — Service Worker v6.0
 * Cache-first offline strategy.
 * The apparatus must operate without network — all planetary calculations,
 * gematric evaluations, and acoustic engines are local.
 *
 * Strategy:
 *   - Install: precache all static assets
 *   - Fetch: cache-first for local assets; network-first for external (Google Fonts)
 *   - Activate: purge stale caches automatically
 */

const CACHE_NAME = 'liber-temporis-v6-1';
const FONT_CACHE = 'liber-temporis-fonts-v1';

// Assets to precache on install
const PRECACHE_URLS = [
  './',
  './index.html',
  './manifest.json',
  './icon-192.png',
  './icon-512.png',
  './icon-180.png',
  './icon-32.png',
  './icon-16.png',
];

// External origins that get their own cache (network-first, falls back to cache)
const FONT_ORIGINS = [
  'https://fonts.googleapis.com',
  'https://fonts.gstatic.com',
];

// ── Install: precache all static assets ──────────────────────────────────────
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(PRECACHE_URLS))
      .then(() => self.skipWaiting())
  );
});

// ── Activate: delete stale caches ────────────────────────────────────────────
self.addEventListener('activate', event => {
  const VALID_CACHES = [CACHE_NAME, FONT_CACHE];
  event.waitUntil(
    caches.keys()
      .then(cacheNames =>
        Promise.all(
          cacheNames
            .filter(name => !VALID_CACHES.includes(name))
            .map(name => caches.delete(name))
        )
      )
      .then(() => self.clients.claim())
  );
});

// ── Fetch: cache-first (local) / network-first (fonts) ───────────────────────
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Font requests: network-first with font cache fallback
  if (FONT_ORIGINS.some(origin => event.request.url.startsWith(origin))) {
    event.respondWith(
      caches.open(FONT_CACHE).then(cache =>
        fetch(event.request)
          .then(response => {
            cache.put(event.request, response.clone());
            return response;
          })
          .catch(() => cache.match(event.request))
      )
    );
    return;
  }

  // Navigation requests: always try network first so updates deploy immediately,
  // fall back to cached index.html for full offline support
  if (event.request.mode === 'navigate') {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(c => c.put(event.request, clone));
          return response;
        })
        .catch(() =>
          caches.match('./index.html')
        )
    );
    return;
  }

  // All other local requests: cache-first
  event.respondWith(
    caches.match(event.request)
      .then(cached => {
        if (cached) return cached;
        return fetch(event.request).then(response => {
          // Only cache same-origin successful responses
          if (
            !response ||
            response.status !== 200 ||
            response.type === 'opaque' ||
            url.origin !== location.origin
          ) {
            return response;
          }
          const clone = response.clone();
          caches.open(CACHE_NAME).then(c => c.put(event.request, clone));
          return response;
        });
      })
  );
});

// ── Message: force update from client ────────────────────────────────────────
self.addEventListener('message', event => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
