// Liber Temporis Service Worker v5.5.1
const CACHE_NAME = 'liber-temporis-v5.5.1';
const ASSETS = [
  './',
  './index.html',
  './manifest.json',
  './icon-192.png',
  './icon-512.png'
];

// Install — cache app shell
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(ASSETS)).then(() => self.skipWaiting())
  );
});

// Activate — clean old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

// Fetch — cache-first for app shell, network-first for everything else
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  // Only handle same-origin requests
  if (url.origin !== location.origin) return;
  
  event.respondWith(
    caches.match(event.request).then(cached => {
      if (cached) {
        // Return cache, but update in background
        fetch(event.request).then(response => {
          if (response && response.status === 200) {
            caches.open(CACHE_NAME).then(cache => cache.put(event.request, response));
          }
        }).catch(() => {});
        return cached;
      }
      return fetch(event.request).then(response => {
        if (response && response.status === 200) {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        }
        return response;
      }).catch(() => {
        // Offline fallback
        if (event.request.destination === 'document') {
          return caches.match('./index.html');
        }
      });
    })
  );
});

// Notification click — open the app
self.addEventListener('notificationclick', event => {
  event.notification.close();
  event.waitUntil(
    self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then(clients => {
      // Focus existing window if available
      for (const client of clients) {
        if (client.url.includes('index.html') || client.url.endsWith('/')) {
          return client.focus();
        }
      }
      // Otherwise open a new window
      return self.clients.openWindow('./');
    })
  );
});

// Push event — future-proofing for server-sent push
self.addEventListener('push', event => {
  const data = event.data ? event.data.json() : {};
  const title = data.title || 'Liber Temporis';
  const options = {
    body: data.body || 'The sky has something to say.',
    icon: './icon-192.png',
    badge: './icon-192.png',
    silent: data.silent !== false,
    tag: data.tag || 'lt-push',
    data: { url: data.url || './' }
  };
  event.waitUntil(self.registration.showNotification(title, options));
});

// Periodic background sync — keep the app alive for notification scheduling
self.addEventListener('periodicsync', event => {
  if (event.tag === 'lt-check') {
    event.waitUntil(
      self.clients.matchAll({ type: 'window' }).then(clients => {
        clients.forEach(client => client.postMessage({ type: 'lt-tick' }));
      })
    );
  }
});
