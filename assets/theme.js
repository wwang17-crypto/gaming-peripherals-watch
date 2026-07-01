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

  function groupByMonth() {
    var list = document.querySelector('.index-list');
    if (!list) return;
    var cards = Array.prototype.slice.call(list.querySelectorAll('.index-card'));
    if (!cards.length) return;

    var monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                      'July', 'August', 'September', 'October', 'November', 'December'];
    var groups = [];   // newest-first, in first-seen order
    var byKey = {};
    cards.forEach(function (card) {
      var dateEl = card.querySelector('.date');
      var m = dateEl && dateEl.textContent.match(/(\d{4})-(\d{2})/);
      if (!m) return;
      var key = m[1] + '-' + m[2];
      if (!byKey[key]) {
        byKey[key] = { label: monthNames[parseInt(m[2], 10) - 1] + ' ' + m[1], cards: [] };
        groups.push(byKey[key]);
      }
      byKey[key].cards.push(card);
    });
    if (groups.length <= 1) return;   // nothing worth folding

    var container = document.createElement('div');
    container.className = 'month-groups';

    groups.forEach(function (g, i) {
      var details = document.createElement('details');
      details.className = 'month-group';
      if (i === 0) details.open = true;   // newest month expanded, rest folded

      var summary = document.createElement('summary');
      var n = g.cards.length;
      summary.innerHTML = '<span class="month-label">' + g.label + '</span>' +
        '<span class="month-count">' + n + ' report' + (n === 1 ? '' : 's') + '</span>';
      details.appendChild(summary);

      var ul = document.createElement('ul');
      ul.className = 'index-list';
      g.cards.forEach(function (c) { ul.appendChild(c); });
      details.appendChild(ul);

      // Cards inside a collapsed month are display:none, so show-more can't measure
      // them until the month is first opened. Re-run then (setupShowMore is idempotent).
      details.addEventListener('toggle', function () { if (details.open) setupShowMore(); });
      container.appendChild(details);
    });

    list.parentNode.replaceChild(container, list);
  }

  function setupShowMore() {
    var selector = '.card-summary, .feedback-item > p, .index-card .summary';
    document.querySelectorAll(selector).forEach(function (el) {
      if (el.classList.contains('empty')) return;
      if (el.dataset.smInit === '1') return;

      requestAnimationFrame(function () {
        if (el.dataset.smInit === '1') return;
        if (el.clientHeight === 0) return;   // hidden (collapsed month) — re-eval when shown
        el.dataset.smInit = '1';
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
    groupByMonth();
    setupShowMore();
  });
})();
