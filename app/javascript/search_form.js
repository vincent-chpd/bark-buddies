document.getElementById('search-bar').onfocus = function() {
  this.placeholder = '';
};

document.getElementById('search-bar').onblur = function() {
  if (this.value === '') {
    this.placeholder = '🔍Type a location...';
  }
};
