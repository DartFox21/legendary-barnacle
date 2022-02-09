'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "78531d0d8cba2bf05eba3daa59b615a8",
"index.html": "2162885cb4b8f19e1f7284eb3928d5a3",
"/": "2162885cb4b8f19e1f7284eb3928d5a3",
"main.dart.js": "c37bfbc52471579598382e16ff644096",
"fb.js": "294cf21a1c7f8a0841630c7d9b7f2ca2",
"chromelogo.png": "4ad6ac6d9054e1698a5711bbd6d4d3cf",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "46ec84975006023103d30bebf3566106",
".git/ORIG_HEAD": "ee03925c96942ab3292df713ca37488a",
".git/config": "1499832c36766db7fdd16904f2fb26c4",
".git/objects/3b/98244bb5eae0d90bf01f9e350eae62283af975": "709cfafa507b6dd627a33c8ee898aa64",
".git/objects/9b/d5739cb6ecf1aa74706a0f71c7c4270b3a70e8": "f4c5bcc13447ec7b56d862de5d597316",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/58/d8e35677daf013ac46fd41005b7c0d2bbe594d": "4729b5a94f5283b28b3bf88ae2d419a0",
".git/objects/34/b16bd0f93e550e8cbffc6f2b4c7b88986e2c91": "e57694810c586699d774232a6f1cf265",
".git/objects/5a/d9ab9b94ff8c5aa9067949877cb413cc951432": "250f04f6480db5fdfda1ff8da545b5bd",
".git/objects/05/c4b209323cc80033751b13a411d12cc00b0c56": "b11611285c24506a5cb89773b7b73d36",
".git/objects/a4/9dee6fbe411052ac512aa65d11734d3b0bcdd4": "3210457abe9bde3f187ffd4923583275",
".git/objects/b5/1e00c7324b13e7785e0074d3acb1b154c546a5": "ed8b13a484fc5577a688a7f1efc08a61",
".git/objects/ad/8174d3e3649c8b191fe1b0ea0e3dd336922997": "f09993e837f76db1ad906bf58a7bad2d",
".git/objects/d7/3f6fa805f4293853a50e2d9ee73200efe32a90": "04e833033ea66cd4cce011b982b72590",
".git/objects/bd/a346ec6f3b7a7c01560f617993e604ab6bddc5": "b3f101f195affca0e13209bc6e2b649e",
".git/objects/d6/70c6bc3157fe5d0b370e852ca91224c0fe2fa7": "3977861fee792cd8a175824ee0d7382b",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/ab/3a2163aea68e1a222b8a7018f2447e3337688b": "f94fbee755066f6df52d83ae58f229ee",
".git/objects/e5/900f8cf143cb03dd9a44d29d5e56a169da65c3": "34e7a1720b984544e480a5f76b1ffe7d",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e2/f6c7f61634d513f9b829b94d37bde19ebec477": "3e46dc9fde5f2ed687edbcd3ec10bb10",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/022f1154699378d9d0e6ffca94f6f576b8c272": "52fd5c49011b2352c4157e992451f846",
".git/objects/f2/f7e570b69d838cf30f59a1f4457a7262c30873": "f5d925ad2209da2ccee3138b11a1d559",
".git/objects/7d/5368b9b7b0ad978cc8929af296a6c9fa7d10a0": "da0cbbfc4556c8e965ff6eec6beaaef0",
".git/objects/89/452c6a137856017871a8b1ffdc8fa1bacb65c3": "47ef74bc439f2fb868cfd94067e73d4b",
".git/objects/87/af9d233b21f31e947004113f1d2f971f6b201f": "58352914b192cfd8020d4da513de9edf",
".git/objects/80/444046f75c827eafc354361f37625f8ec013b1": "bf244afb011a73a41446f06709428635",
".git/objects/74/fce7ebedfd2c5672db4da95384e96405f8ab30": "a254dbd92c883ac02f36a9e37a114f9e",
".git/objects/1a/05def7fd4ee7179f906b65b4c0c2576c5cfc1f": "225371e0294019fd1528e8b59f6cd339",
".git/objects/28/e0da272a695d40c17af3a0f0af3afceeb8928e": "bcf2b00266741d08997840ad3e8e7937",
".git/objects/17/344a42a50b16abca546627c407ecdf4007258a": "a08fc0607162ff956449b6f00c6950d9",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/21/7754b6ccd9a9e4abafe0718fb7107ddf027167": "b1416ef52ea3f80971020459671cafef",
".git/objects/86/631cf9fe22d579ac4a5294849321959f7618b0": "f50ecb02ccea72ab14e3f91eb06489b2",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/9f/e0fa57d1ebeb13d94d7f04075b4ec8c28bc7ff": "cf33ad6ad02686223fb4c91f25dab87b",
".git/objects/07/1a8176108383354b8f03496d6a129c27eb7615": "23fddd8c23b964cbb7a0f84caf41e8d2",
".git/objects/00/18f535545d5c93c727910d29fbaf4984b82599": "20d404aac5e2407dd1a288061657d43a",
".git/objects/9a/381a39fe785dcf9116e82abada02c99d19f9f6": "bbfe7201dc53a7caaa4a8765d5c5a780",
".git/objects/36/b9fbb51027f98503944f4f9e5ad9050b3550d3": "947a33a1598bef5595b208cdeef95646",
".git/objects/31/68f8434395264e235afc28174e42b00bb330f5": "24bb4eb86ee714da25e7ef7526e89be9",
".git/objects/30/4cbc76ebd4644db386e6dc496083c6f941a0a9": "cbfc471783db169de34add43b4e6faa7",
".git/objects/37/27b121c3c505c10e51a57e0b2ba5da047f16a2": "2133d64eee0cf4cc003fcf1e6249bf64",
".git/objects/99/1c8979d168007b04f944492bb3d263764319ef": "c02590c7b7e8b8eada25f6c107e7ead2",
".git/objects/52/8274dc0568883bda5b4f9c2481e30f8754b371": "25607d0700223475ce082501350dcbd4",
".git/objects/55/8fb6791e1dadcc9bca8464db7b3b94abb96f94": "6c508b2e1c7189e99fac389e5401ae62",
".git/objects/90/fa7a6fa9dbbd1a3a14696aeffaa02a32a21668": "f37a15dabf88a9234575f64d119d4abb",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/0d7aabe1ea39293427edfc29ce17ae37216a42": "d99b0b27d1046f25d124a869592fad79",
".git/objects/db/96fa29024094e8a72035f950ba7ab38b85b97b": "96173ea8c8c12d036e0fb466553c55a2",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/c8ffc1d4f215aee952b6bfa99219baaedc4a7b": "9ec934e18b9f80d3d1076a3b1fe30eb3",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/e8/6ab67cfeb9fa99133c5d74d719480068862bc5": "62a01f203162d276e7ae8fb59948ee4b",
".git/objects/f1/bf55f9fca60d0b7ee7050532d2562ca693757b": "a21734e8683ee1c0a8c29ea439562bfe",
".git/objects/e7/ac953bc483c924328548bceb85ac659756370a": "d7381104375f59c564ee08c5cdf1a55e",
".git/objects/e0/2cb74ad625c544d5079080cf886611d17d86b8": "bfcb5f7e3bacd49f435de86e506bc561",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/83/e64b1c12015f7aade68641c91f1d5b4a67ee72": "ab9a5ccc4097be877fccad5ad179937c",
".git/objects/83/acbed245c8089347bd32db72b72a177f66669e": "760db02878144ed9d6abafeedf3b96de",
".git/objects/1b/5791d10d2eea5420b96a0b457a6b570ea257e3": "ce9cd59fadbbf9c818e677340091fc5e",
".git/objects/1b/bf388b8096d2c24b4cb9eba745598ed5266897": "faf3a5071bb339d316309c30882845e9",
".git/objects/70/f48953adfd0e0b482347aaf85dc341aca56622": "f5e9929bd5b732a0230d8e41479c75ab",
".git/objects/23/8b1c34e724acbcf9a5734f63d07eab2625f5ed": "6435a26a531780f7a887cefdd471c18e",
".git/objects/1d/cb432b8e2de2585cc7b74cd421c83556ccc996": "8d81f5ba5761725d044f38a4d32c0fa6",
".git/objects/82/46c04e4bf28aa44e5b33b1cc8c784775f613ac": "180459f5587e44d73d41151f8227386e",
".git/objects/40/f1694ba4c97cdfaaa99a6459feab9a24614586": "aca2ed34561ba1ba8fc7d7674cd50113",
".git/objects/40/05246d0b7eabb9b0e119a1f81dcbe910e09554": "74f4dde9538040aacf99f242b674819a",
".git/objects/2e/4cecb73eaec3b0033172c4272eba29a900ea64": "7ed17e765297920ba044c7dd7bac5a79",
".git/objects/8b/800dfeff8232b8c8a8223d31782fb0031e3740": "5d08a68a78cc7589837dbd2f0081ef74",
".git/objects/7f/98c6c601c9f4ce69e34b607655d085167cfe9d": "0a870a171565ad14596b9706d5ff1aee",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "0aebccfd5866bfc3e7c8f625230c22f7",
".git/logs/HEAD": "165cf47392f1371fd4492367e87519c5",
".git/logs/refs/heads/main": "34372d950b2e4dfc9cd6317fbbc83d43",
".git/logs/refs/remotes/origin/main": "3e77c81793b743328388e2c7046901e4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "e4db8c12ee125a8a085907b757359ef0",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ecbb0cb5ffb7d773cd5b2407b210cc3b",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/update.sample": "517f14b9239689dff8bda3022ebd9004",
".git/refs/heads/main": "1f0619f059a48c23cafcd586ee35aa35",
".git/refs/remotes/origin/main": "1f0619f059a48c23cafcd586ee35aa35",
".git/index": "6448073ae28f0795da0a52f91ba3092a",
".git/COMMIT_EDITMSG": "b105e9dc12a100949f4138a64890c3dd",
".git/FETCH_HEAD": "3cb763b9a296fc72df5db95f8c00af5d",
"assets/images/chromelogo.png": "4ad6ac6d9054e1698a5711bbd6d4d3cf",
"assets/AssetManifest.json": "67b182f0dc362f5ffce2f69bbfa97e3b",
"assets/NOTICES": "b16ae63fb0ef13183a3696ec0fc566be",
"assets/FontManifest.json": "e8f37dc9b63a5a9781c27963206c5888",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/iconsax/lib/assets/fonts/iconsax.ttf": "071d77779414a409552e0584dcbfd03d",
"assets/fonts/AirbnbCerealBold.ttf": "c94c29feb80b02db176028d16fc634d2",
"assets/fonts/AirbnbCerealBook.ttf": "86b15ac031e0507ad790afafd9adf7f7",
"assets/fonts/AirbnbCerealBlack.ttf": "4395b29d9210bd75051ebce1e66e186d",
"assets/fonts/AirbnbCerealExtraBold.ttf": "0a0cbe1eca15f71b7187b38b1173eb98",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/fonts/AirbnbCerealMedium.ttf": "d9fb3054e00c65841121da81c48e4fb1",
"assets/fonts/AirbnbCerealLight.ttf": "1f9c7d320137974038c2f1a7300a1577",
"canvaskit/canvaskit.js": "43fa9e17039a625450b6aba93baf521e",
"canvaskit/profiling/canvaskit.js": "f3bfccc993a1e0bfdd3440af60d99df4",
"canvaskit/profiling/canvaskit.wasm": "a9610cf39260f60fbe7524a785c66101",
"canvaskit/canvaskit.wasm": "04ed3c745ff1dee16504be01f9623498"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
