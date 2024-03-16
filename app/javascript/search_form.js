document.getElementById('search-bar').onfocus = function() {
  this.placeholder = '';
};

document.getElementById('search-bar').onblur = function() {
  if (this.value === '') {
    this.placeholder = '🔍Type a location...';
  }
};


document.getElementById('clear-button').addEventListener('click', function() {
  var searchBar = document.getElementById('search-bar');
  searchBar.value = '';
  searchBar.placeholder = "🔍Type a location...";
  this.style.display = 'none';
});

document.getElementById('search-bar').addEventListener('input', function() {
  if (this.value.length > 0) {
    document.getElementById('clear-button').style.display = 'block';
  } else {
    document.getElementById('clear-button').style.display = 'none';
  }
});
