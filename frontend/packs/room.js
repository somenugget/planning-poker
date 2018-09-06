import Vue from 'vue'
import Room from '../components/room'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('room-root');
  const props = JSON.parse(el.dataset.props);

  new Vue({
    el,
    render: (createElement) => createElement(Room, { props })
  });
});
