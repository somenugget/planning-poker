import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import Room from '../components/Room'

Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('room-root');
  const props = JSON.parse(el.dataset.props);
  const estimation_options = [{
    id: 1,
    label: '1/2',
    estimation: 0.5
  }, {
    id: 2,
    label: '1',
    estimation: 1
  }, {
    id: 3,
    label: '3',
    estimation: 3
  }, {
    id: 4,
    label: '5',
    estimation: 5
  }, {
    id: 5,
    label: '8',
    estimation: 8
  }]; // TODO: think, how to store in DB different sets of estimation options

  new Vue({
    el,
    render: (createElement) => createElement(Room, { props: { estimation_options, ...props } })
  });
});
