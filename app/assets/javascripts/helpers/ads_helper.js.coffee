Batman.mixin Batman.Filters,
  displayPrice: (ad) ->
    return undefined if typeof ad is 'undefined'
    switch ad.get('sale_type')
      when 'fixed'
        "$#{(ad.get('price') || 0).toFixed(2)}"
      when 'free'
        'free'
      when 'trade'
        'trade/swap'

  simpleFormat: (text) ->
    return undefined if typeof text is 'undefined'
    text = text.replace(/(\n\n+)|(\r\r+)|(\r\n(\r\n)+)/g, "</p>\n\n<p>")  # 2+ newline  -> paragraph
    text = text.replace(/([^\n]\n)(?=[^\n])/g, '\1<br />') # 1 newline   -> br
    text = "<p>#{text}</p>"
    text

  autolink: (text) ->
    return undefined if typeof text is 'undefined'
    # Turns all urls into clickable links.
    text.replace AUTO_LINK_RE, (href, scheme, offset) ->
      punctuation = []

      if isAutoLinked(text.slice(0, offset), text.slice(offset + href.length))
        # do not change string; URL is already linked
        href
      else
        linkText = href
        href = 'http://' + href unless scheme
        "<a href=\"#{href}\">#{linkText}</a>"

  prettyDate: (x) -> x
# regexps for determining context, used high-volume
AUTO_LINK_RE = ///
  (?: ([0-9A-Za-z+.:-]+:)// | www\. )
  [^\s<]+
///g
AUTO_LINK_CRE = [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/i, /<\/a>/i]
AUTO_EMAIL_RE = /[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/

# Detects already linked context or position in the middle of a tag
isAutoLinked = (left, right) ->
  (AUTO_LINK_CRE[0].exec(left) and AUTO_LINK_CRE[1].exec(right)) or
    (AUTO_LINK_CRE[2].exec(left) and !AUTO_LINK_CRE[3].exec(right))
