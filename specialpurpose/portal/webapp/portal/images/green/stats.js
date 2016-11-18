(function () {
    var d = document, b = document.getElementsByTagName('body')[0], i = document.createElement('img');
    var src = '/Stats/?w=' + screen.width + '&h=' + screen.height + '&aw=' + screen.availWidth + '&ah=' + screen.availHeight;
    src += '&href=' + encodeURIComponent(document.URL) + '&ref=' + encodeURIComponent(document.referrer);
    i.src = src;
})();