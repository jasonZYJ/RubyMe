$.fn.highlight = function(keyword) {
 function innerHighlight(node, keyword) {
  var query = new RegExp("(\\b" + keyword + "\\b)", "gim");

  var skip = 0;
  if (node.nodeType == 3) {
    var match = query.exec(node.data);
    if (match) {
      var pos = match.index;
      var spannode = document.createElement('span');
      spannode.className = 'highlight';
      var middlebit = node.splitText(pos);
      var endbit = middlebit.splitText(keyword.length);
      var middleclone = middlebit.cloneNode(true);
      spannode.appendChild(middleclone);
      middlebit.parentNode.replaceChild(spannode, middlebit);
      skip = 1;
    }
  }
  else if (node.nodeType == 1 && node.childNodes && !/(script|style)/i.test(node.tagName)) {
   for (var i = 0; i < node.childNodes.length; ++i) {
    i += innerHighlight(node.childNodes[i], keyword);
   }
  }
  return skip;
 }
 return this.length && keyword && keyword.length ? this.each(function() {
  innerHighlight(this, keyword.toUpperCase());
 }) : this;
};

$.fn.removeHighlight = function() {
 return this.find("span.highlight").each(function() {
  this.parentNode.firstChild.nodeName;
  with (this.parentNode) {
   replaceChild(this.firstChild, this);
   normalize();
  }
 }).end();
};
