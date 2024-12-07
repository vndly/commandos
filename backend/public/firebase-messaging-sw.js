importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-firestore.js');

const firebaseConfig = {
    authDomain: "atomic-prototype.firebaseapp.com",
    projectId: "atomic-prototype",
    storageBucket: "atomic-prototype.firebasestorage.app",
    messagingSenderId: "1079322227234",
    appId: "1:1079322227234:web:3a79e55e7d553f5abed07b",
    measurementId: "G-ZRTPXKKG5Y",
}

firebase.initializeApp(firebaseConfig);