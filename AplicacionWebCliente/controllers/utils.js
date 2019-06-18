var json2html = require('node-json2html');
  

exports.transformDataWith = (data,noMostrar=[],headers=[])=> {
  
  var elems = []
  var headersHtml=` <thead><tr>`
  var headersHtmlEnd = `</tr> </thead><tbody>`
  var endTbody = '</tbody>'
  var t = {'<>':'tr','html':elems};
  if(headers.length>0){
    for(x in headers) {
      elems.push({'<>':'td','html':'${'+x+'}'})
      headersHtml+= '<th>'+x+'</th>';
    }
  }else{
    for(x in data[0]) {

      var noMuestra = noMostrar.includes(x)
      if(!noMuestra){
        elems.push({'<>':'td','html':'${'+x+'}'})
        headersHtml+= '<th>'+x+'</th>';
      }
    }
  }

  headersHtml+=headersHtmlEnd
  var html = headersHtml
  html += json2html.transform(data,t);
  html += endTbody
  return html
}
