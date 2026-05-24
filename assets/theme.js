(function () {
  function setTheme(t) {
    if (t === 'light') {
      document.documentElement.setAttribute('data-theme', 'light');
    } else {
      document.documentElement.removeAttribute('data-theme');
    }
    try { localStorage.setItem('theme', t); } catch (e) {}
  }

  function setupThemeToggle() {
    var btn = document.querySelector('.theme-toggle');
    if (!btn) return;
    btn.addEventListener('click', function () {
      var current = document.documentElement.getAttribute('data-theme') === 'light' ? 'light' : 'dark';
      setTheme(current === 'light' ? 'dark' : 'light');
    });
  }

  function setupShowMore() {
    var selector = '.card-summary, .feedback-item > p';
    document.querySelectorAll(selector).forEach(function (el) {
      if (el.classList.contains('empty')) return;
      if (el.dataset.smInit === '1') return;
      el.dataset.smInit = '1';

      requestAnimationFrame(function () {
        if (el.scrollHeight <= el.clientHeight + 1) return;

        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'show-more';
        btn.textContent = 'Show more';
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          e.stopPropagation();
          var expanded = el.classList.toggle('expanded');
          btn.textContent = expanded ? 'Show less' : 'Show more';
        });
        el.parentNode.insertBefore(btn, el.nextSibling);
      });
    });
  }

  window.addEventListener('DOMContentLoaded', function () {
    setupThemeToggle();
    setupShowMore();
  });
})();
