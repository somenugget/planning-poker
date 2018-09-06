import Vue from 'vue'
import Room from '../components/room'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'));
  const app = new Vue({
    el,
    render: h => h(Room)
  });

  console.log(app)
});
