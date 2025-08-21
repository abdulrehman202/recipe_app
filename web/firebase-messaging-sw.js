importScripts('https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js');

const firebaseConfig = {
  apiKey:  "AIzaSyCIKqC_OsFBcIpLuK-78tyUubBCAjYcl4Q",
  authDomain: "recipe-app-19207.firebaseapp.com",
  projectId: "recipe-app-19207",
  storageBucket: "recipe-app-19207.appspot.com",
  messagingSenderId: "963673480986",
  appId: "1:1042125956309:web:7f31f4fe409e44887e2e5c"
};

var firebase = FirebaseWeb.instance.app;

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Received background message: ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = { body: payload.notification.body };

  self.registration.showNotification(notificationTitle, notificationOptions);
});