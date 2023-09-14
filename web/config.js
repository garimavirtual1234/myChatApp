// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBsrKlc8R8QWvDyp59dwih-IPtQr6OFMrs",
  authDomain: "chatapp-84e0a.firebaseapp.com",
  projectId: "chatapp-84e0a",
  storageBucket: "chatapp-84e0a.appspot.com",
  messagingSenderId: "746494261207",
  appId: "1:746494261207:web:44797ddd5df88f65c33d92",
  measurementId: "G-F15D8M9WBF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);