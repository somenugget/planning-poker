const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

export default {
  vote (roomUserId, estimation) {
    return this._request('/api/votes', 'POST', {
      vote: {
        estimation,
        room_user_id: roomUserId
      }
    });
  },

  closeRoom (roomId) {
    return this._request(`/api/rooms/${roomId}`, 'PUT', {
      closed: true
    });
  },

  _request (url, method = 'GET', body = {}, options = {}) {
    return fetch(url, {
      method,
      body: JSON.stringify(body),
      headers: {
        'X-CSRF-Token': csrfToken,
        'Content-Type': 'application/json',
        ...options.headers
      },
      ...options
    }).then((response) => response.json());
  }
};
