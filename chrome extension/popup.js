document.addEventListener('DOMContentLoaded', function() {
    // Get the current tab's URL and display it in the popup
    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      var tab = tabs[0];
      var url = tab.url;
      var urlElement = document.getElementById('url');
      urlElement.textContent = url;
    });
  });
  