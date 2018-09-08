import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import Room from '../components/room'

Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('room-root');
  const props = JSON.parse(el.dataset.props);

  new Vue({
    el,
    render: (createElement) => createElement(Room, { props })
  });
});
