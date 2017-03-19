<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: narrow-indirect.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="https://www.emacswiki.org/emacs?action=edit;id=narrow-indirect.el" /><link type="text/css" rel="stylesheet" href="/light.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="https://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: narrow-indirect.el" href="https://www.emacswiki.org/emacs?action=rss;rcidonly=narrow-indirect.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="https://www.emacswiki.org/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="https://www.emacswiki.org/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="https://www.emacswiki.org/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for narrow-indirect.el only"
      href="https://www.emacswiki.org/emacs?action=rss;rcidonly=narrow-indirect.el" /><meta content="width=device-width" name="viewport" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  // https://stackoverflow.com/questions/280634/endswith-in-javascript
  if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;

	items = toc.getElementsByTagName('a');
	for (var i = 0; i < items.length; i++) {
	  while (items[i].textContent.endsWith('✎')) {
            var text = items[i].childNodes[0].nodeValue;
	    items[i].childNodes[0].nodeValue = text.substring(0, text.length - 1);
	  }
	}
      }
    }
  }

  addOnloadEvent(initToc);
  </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="default"><div class="header"><a class="logo" href="https://www.emacswiki.org/emacs/SiteMap"><img alt="[Home]" src="/emacs_logo.png" class="logo" /></a><div class="menu"><span class="gotobar bar"><a href="https://www.emacswiki.org/emacs/SiteMap" class="local">SiteMap</a> <a href="https://www.emacswiki.org/emacs/Search" class="local">Search</a> <a href="https://www.emacswiki.org/emacs/ElispArea" class="local">ElispArea</a> <a href="https://www.emacswiki.org/emacs/HowTo" class="local">HowTo</a> <a class="local" href="https://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="https://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="https://www.emacswiki.org/emacs/News">News</a> <a href="https://www.emacswiki.org/emacs/Problems" class="local">Problems</a> <a class="local" href="https://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><form method="get" action="https://www.emacswiki.org/emacs" enctype="multipart/form-data" class="search" accept-charset="utf-8"><p><label for="search">Search:</label> <input type="text" name="search"  size="20" accesskey="f" id="search" /> <label for="searchlang">Language:</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="Go!" /></p></form></div><h1><a rel="nofollow" href="https://www.emacswiki.org/emacs?search=%22narrow-indirect%5c.el%22" title="Click to search for references to this page">narrow-indirect.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/narrow-indirect.el">Download</a> <a href="https://github.com/emacsmirror/emacswiki.org/blob/master/narrow-indirect.el">Git</a> <a href="http://www.emacswiki.org/narrow-indirect.el">Homepage</a></p><pre><span class="comment">;;; narrow-indirect.el --- Narrow using an indirect buffer that is a clone</span>
<span class="comment">;;</span>
<span class="comment">;; Filename: narrow-indirect.el</span>
<span class="comment">;; Description: Narrow using an indirect buffer that is a clone</span>
<span class="comment">;; Author: Drew Adams</span>
<span class="comment">;; Maintainer: Drew Adams</span>
<span class="comment">;; Copyright (C) 2014-2016, Drew Adams, all rights reserved.</span>
<span class="comment">;; Created: Sun May 11 08:05:59 2014 (-0700)</span>
<span class="comment">;; Version: 0</span>
<span class="comment">;; Package-Requires: ()</span>
<span class="comment">;; Last-Updated: Thu Dec 31 15:44:16 2015 (-0800)</span>
<span class="comment">;;           By: dradams</span>
<span class="comment">;;     Update #: 202</span>
<span class="comment">;; URL: http://www.emacswiki.org/narrow-indirect.el</span>
<span class="comment">;; Doc URL: http://www.emacswiki.org/NarrowIndirect</span>
<span class="comment">;; Keywords: narrow indirect buffer clone view multiple-modes</span>
<span class="comment">;; Compatibility: GNU Emacs: 22.x, 23.x, 24.x, 25.x</span>
<span class="comment">;;</span>
<span class="comment">;; Features that might be required by this library:</span>
<span class="comment">;;</span>
<span class="comment">;;   None</span>
<span class="comment">;;</span>
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;</span>
<span class="comment">;;; Commentary:</span>
<span class="comment">;;</span>
<span class="comment">;;  Narrow using an indirect buffer that is a clone of the current</span>
<span class="comment">;;  buffer (which becomes the base buffer for the clone).</span>
<span class="comment">;;</span>
<span class="comment">;;  Such an indirect buffer gives you a different view of a portion of</span>
<span class="comment">;;  the buffer, or even of the whole buffer (use `C-x h C-x 4 n n').</span>
<span class="comment">;;  It always has the same text and text properties, but otherwise it</span>
<span class="comment">;;  is pretty independent.</span>
<span class="comment">;;</span>
<span class="comment">;;  In particular, you can kill an indirect buffer without affecting</span>
<span class="comment">;;  its base buffer.  You will likely want to kill indirect narrowed</span>
<span class="comment">;;  buffers rather than widening them.</span>
<span class="comment">;;</span>
<span class="comment">;;  You can use indirect buffers for more than you might think.  You</span>
<span class="comment">;;  can use clones taken from portions of Dired buffers, for example,</span>
<span class="comment">;;  to give you useful (active) views into a directory listing.  There</span>
<span class="comment">;;  are only a few keys/commands (such as `<span class="constant important">g</span>' to update the listing)</span>
<span class="comment">;;  that do not work, because they depend on a view of the whole Dired</span>
<span class="comment">;;  buffer.  Experiment, and you will no doubt find interesting new</span>
<span class="comment">;;  uses for indirect buffers.</span>
<span class="comment">;;</span>
<span class="comment">;;  Note: Because an indirect clone shares text properties with its</span>
<span class="comment">;;  base buffer, if you give it a different major mode that uses</span>
<span class="comment">;;  different font-locking then the font-locking of the base buffer</span>
<span class="comment">;;  changes the same way.  However, you can restore the font-locking</span>
<span class="comment">;;  appropriate to the base buffer, by just toggling `<span class="constant important">font-lock-mode</span>'</span>
<span class="comment">;;  off and on again there.</span>
<span class="comment">;;</span>
<span class="comment">;;  See the Emacs manual, node `Indirect Buffers'.</span>
<span class="comment">;;</span>
<span class="comment">;;  It is helpful to be able to easily distinguish indirect buffers</span>
<span class="comment">;;  from non-indirect buffers.  This library offers two ways to do</span>
<span class="comment">;;  this, for the indirect buffers it creates:</span>
<span class="comment">;;</span>
<span class="comment">;;  * The buffer name of an indirect narrowed buffer starts with a</span>
<span class="comment">;;    prefix that you can set using option `<span class="constant important">ni-buf-name-prefix</span>'.  The</span>
<span class="comment">;;    default value is `<span class="constant important">I-</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  * The name of an indirect narrowed buffer is highlighted in the</span>
<span class="comment">;;    mode line using face `<span class="constant important">ni-mode-line-buffer-id</span>' instead of face</span>
<span class="comment">;;    `<span class="constant important">mode-line-buffer-id</span>'.  To turn this off, just customize the</span>
<span class="comment">;;    former to be the same as the latter.</span>
<span class="comment">;;</span>
<span class="comment">;;  By default, the name of an indirect narrowed buffer reflects the</span>
<span class="comment">;;  name of its base buffer and the text of the narrowed region (or</span>
<span class="comment">;;  the name of the defined object, in the case of</span>
<span class="comment">;;  `<span class="constant important">ni-narrow-to-defun-indirect-other-window</span>').  But you can control</span>
<span class="comment">;;  this in several ways.  See the command doc strings and user</span>
<span class="comment">;;  options `<span class="constant important">ni-buf-name-prefix</span>', `<span class="constant important">ni-narrowed-buf-name-max</span>', and</span>
<span class="comment">;;  `<span class="constant important">ni-buf-name-separator</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  If you use Emacs 24.4 or later then invisible buffer text is</span>
<span class="comment">;;  filtered out from the name of the indirect buffer.  For example,</span>
<span class="comment">;;  if you invoke `<span class="constant important">ni-narrow-to-region-indirect-other-window</span>' with an</span>
<span class="comment">;;  active region in a Dired buffer that is hiding details, then the</span>
<span class="comment">;;  (invisible) details will not be included in the indirect-buffer</span>
<span class="comment">;;  name.</span>
<span class="comment">;;</span>
<span class="comment">;;  To customize the behavior of this library, do this:</span>
<span class="comment">;;</span>
<span class="comment">;;    M-x customize-group Narrow-Indirect</span>
<span class="comment">;;</span>
<span class="comment">;;  Suggested key bindings:</span>
<span class="comment">;;</span>
<span class="comment">;;   (define-key ctl-x-4-map <span class="string">"nd"</span> 'ni-narrow-to-defun-indirect-other-window)</span>
<span class="comment">;;   (define-key ctl-x-4-map <span class="string">"nn"</span> 'ni-narrow-to-region-indirect-other-window)</span>
<span class="comment">;;   (define-key ctl-x-4-map <span class="string">"np"</span> 'ni-narrow-to-page-indirect-other-window)</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;;  User options defined here:</span>
<span class="comment">;;</span>
<span class="comment">;;    `<span class="constant important">ni-buf-name-prefix</span>', `<span class="constant important">ni-narrowed-buf-name-max</span>',</span>
<span class="comment">;;    `<span class="constant important">ni-buf-name-separator</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  Faces defined here:</span>
<span class="comment">;;</span>
<span class="comment">;;    `<span class="constant important">ni-mode-line-buffer-id</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  Commands defined here:</span>
<span class="comment">;;</span>
<span class="comment">;;    `<span class="constant important">ni-narrow-to-defun-indirect-other-window</span>',</span>
<span class="comment">;;    `<span class="constant important">ni-narrow-to-page-indirect-other-window</span>',</span>
<span class="comment">;;    `<span class="constant important">ni-narrow-to-region-indirect-other-window</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  Non-interactive functions defined here:</span>
<span class="comment">;;</span>
<span class="comment">;;    `<span class="constant important">ni-buffer-substring-collapsed-visible</span>'.</span>
<span class="comment">;;</span>
<span class="comment">;;  Acknowledgments:</span>
<span class="comment">;;</span>
<span class="comment">;;   The idea and original code for a command that combines narrowing</span>
<span class="comment">;;   with cloning a buffer as an indirect-buffer is due to Zane Ashby:</span>
<span class="comment">;;   http://demonastery.org/2013/04/emacs-narrow-to-region-indirect/.</span>
<span class="comment">;;</span>
<span class="comment">;;   In Emacs bug thread #17401, Phil Sainty proposed adding three</span>
<span class="comment">;;   commands to Emacs based on this approach.  Lennart Borgman</span>
<span class="comment">;;   contributed code that uses, in the cloned buffer name, some text</span>
<span class="comment">;;   based on the narrowed region.</span>
<span class="comment">;;</span>
<span class="comment">;;   The code in `narrow-indirect.el' extends this a bit and provides</span>
<span class="comment">;;   a couple of user options and some alternative (prefix-argument)</span>
<span class="comment">;;   behavior.  It is doubtful that Emacs Dev will ever adopt features</span>
<span class="comment">;;   such as those defined here, and if they do then this library can</span>
<span class="comment">;;   at least help for Emacs versions prior to their addition.</span>
<span class="comment">;;</span>
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;</span>
<span class="comment">;;; Change Log:</span>
<span class="comment">;;</span>
<span class="comment">;; 2014/09/14 dadams</span>
<span class="comment">;;     Added: ni-buffer-substring-collapsed-visible.  Thx to Adrian for suggestion.</span>
<span class="comment">;;     Renamed: ni-narrow-to-defun-other-window  to ni-narrow-to-defun-indirect-other-window,</span>
<span class="comment">;;              ni-narrow-to-region-other-window to ni-narrow-to-region-indirect-other-window.</span>
<span class="comment">;;     ni-narrow-to-region-indirect-other-window: Use ni-buffer-substring-collapsed-visible.</span>
<span class="comment">;;     ni-buffer-substring-collapsed-visible: Fixed regexps and replacements.</span>
<span class="comment">;;     Added declare-function for which-function.</span>
<span class="comment">;; 2014/07/14 dadams</span>
<span class="comment">;;     ni-narrow-to-region-other-window: Just use buffer-substring-of-visible, not split-string-by-property.</span>
<span class="comment">;; 2014/05/29 dadams</span>
<span class="comment">;;     Added: ni-buf-name-separator.  And use  | , not  / , as the value.</span>
<span class="comment">;;     ni-narrow-to-region-other-window:</span>
<span class="comment">;;      Soft-require subr+.el, for split-string-by-property.  Remove invisible text from name.</span>
<span class="comment">;;      Use ni-buf-name-separator.</span>
<span class="comment">;; 2014/05/17 dadams</span>
<span class="comment">;;     Added autoload cookies.</span>
<span class="comment">;; 2014/05/11 dadams</span>
<span class="comment">;;     Created.</span>
<span class="comment">;;</span>
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;</span>
<span class="comment">;; This program is free software; you can redistribute it and/or</span>
<span class="comment">;; modify it under the terms of the GNU General Public License as</span>
<span class="comment">;; published by the Free Software Foundation; either version 3, or</span>
<span class="comment">;; (at your option) any later version.</span>
<span class="comment">;;</span>
<span class="comment">;; This program is distributed in the hope that it will be useful,</span>
<span class="comment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="comment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU</span>
<span class="comment">;; General Public License for more details.</span>
<span class="comment">;;</span>
<span class="comment">;; You should have received a copy of the GNU General Public License</span>
<span class="comment">;; along with this program; see the file COPYING.  If not, write to</span>
<span class="comment">;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth</span>
<span class="comment">;; Floor, Boston, MA 02110-1301, USA.</span>
<span class="comment">;;</span>
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;</span>
<span class="comment">;;; Code:</span>

(<span class="keyword">defgroup</span> <span class="type">Narrow-Indirect</span> nil
  <span class="string">"Narrow using an indirect buffer."</span>
  <span class="builtin">:prefix</span> <span class="string">"ni-"</span> <span class="builtin">:group</span> 'editing
  <span class="builtin">:link</span> `(url-link <span class="builtin">:tag</span> <span class="string">"Send Bug Report"</span>
          ,(concat <span class="string">"mailto:"</span> <span class="string">"drew.adams"</span> <span class="string">"@"</span> <span class="string">"oracle"</span> <span class="string">".com?subject=\
narrow-indirect.el bug: \
<span class="type">&amp;body=Describe</span> bug here, starting with `emacs -q'.  \
Don't forget to mention your Emacs and library versions."</span>))
  <span class="builtin">:link</span> '(url-link <span class="builtin">:tag</span> <span class="string">"Other Libraries by Drew"</span> <span class="string">"http://www.emacswiki.org/DrewsElispLibraries"</span>)
  <span class="builtin">:link</span> '(url-link <span class="builtin">:tag</span> <span class="string">"Download"</span> <span class="string">"http://www.emacswiki.org/narrow-indirect.el"</span>)
  <span class="builtin">:link</span> '(url-link <span class="builtin">:tag</span> <span class="string">"Description"</span> <span class="string">"http://www.emacswiki.org/NarrowIndirect"</span>)
  <span class="builtin">:link</span> '(emacs-commentary-link <span class="builtin">:tag</span> <span class="string">"Commentary"</span> <span class="string">"narrow-indirect"</span>))

(<span class="keyword">defcustom</span> <span class="variable">ni-narrowed-buf-name-max</span> 60
  <span class="string">"Max length of cloned indirect buffer name, for narrowing commands."</span>
  <span class="builtin">:type</span> '(restricted-sexp <span class="builtin">:tag</span> <span class="string">"Max length of buffer name"</span> <span class="builtin">:match-alternatives</span> ((<span class="keyword elisp">lambda</span> (x) (and (integerp x)  (&gt; x 0))))
          <span class="builtin">:value</span> ignore)
  <span class="builtin">:group</span> 'Narrow-Indirect)

(<span class="keyword">defcustom</span> <span class="variable">ni-buf-name-prefix</span> <span class="string">"I-"</span>
  <span class="string">"Name prefix for indirect buffer cloned by `<span class="constant important">narrow-*-indirect*</span>' commands.
Using a non-empty prefix lets you easily distinguish the indirect
buffers from the original."</span>
  <span class="builtin">:type</span> 'string <span class="builtin">:group</span> 'Narrow-Indirect)

(<span class="keyword">defcustom</span> <span class="variable">ni-buf-name-separator</span> <span class="string">" | "</span>
  <span class="string">"Separator string used between the buffer name and the object name.
Used by `<span class="constant important">ni-narrow-to-region-indirect-other-window</span>' (without a
non-negative prefix arg)."</span>
  <span class="builtin">:type</span> 'string <span class="builtin">:group</span> 'Narrow-Indirect)

(<span class="keyword">defface</span> <span class="variable">ni-mode-line-buffer-id</span> '((t (<span class="builtin">:box</span> (<span class="builtin">:line-width</span> 1 <span class="builtin">:color</span> <span class="string">"green"</span>))))
  <span class="string">"Like `<span class="constant important">mode-line-buffer-id</span>', but for a narrowed indirect clone buffer."</span>
  <span class="builtin">:group</span> 'Narrow-Indirect <span class="builtin">:group</span> 'mode-line-faces <span class="builtin">:group</span> 'basic-faces)

(<span class="keyword cl">declare</span>-function which-function <span class="string">"which-func"</span> ())
<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">ni-narrow-to-defun-indirect-other-window</span> (<span class="type">&amp;optional</span> full-name text)
  <span class="string">"`<span class="constant important">narrow-to-defun</span>' in a cloned indirect buffer in the other window.
The name of the indirect buffer depends on the use of a prefix arg:

* No prefix arg: the current buffer name, but with ` | NAME'
  appended, where NAME is the name of the object defined by the defun.
  (Actually, option `<span class="constant important">ni-buf-name-separator</span>' prefixes NAME.  \" | \" is
  the default value of this option.)

* Prefix arg &lt; 0 : like no prefix arg, but you are prompted for NAME.

* Prefix arg &gt;= 0: you are prompted for the full buffer name.

However, the buffer name is in any case truncated at
`<span class="constant important">ni-narrowed-buf-name-max</span>' chars.

Non-interactively:
* Non-nil FULL-NAME is the full buffer name, and TEXT is ignored.
* Non-nil TEXT is used for NAME, if FULL-NAME is nil.

See `<span class="constant important">clone-indirect-buffer</span>'."</span>
  (interactive (list (and current-prefix-arg
                          (natnump (prefix-numeric-value current-prefix-arg))
                          (read-string <span class="string">"Buffer name: "</span>))
                     (and current-prefix-arg
                          (&lt; (prefix-numeric-value current-prefix-arg) 0)
                          (read-string <span class="string">"Buffer name suffix: "</span>))))
  (<span class="keyword elisp">let</span> ((here  (point)))
    (mark-defun)
    (ni-narrow-to-region-indirect-other-window
     (region-beginning) (region-end) here full-name
     (and (not full-name)  (or text  (<span class="keyword elisp">progn</span> (<span class="keyword">require</span> '<span class="constant">which-func</span>) (which-function)))))))

<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">ni-narrow-to-region-indirect-other-window</span> (start end here <span class="type">&amp;optional</span> full-name text msgp)
  <span class="string">"`<span class="constant important">narrow-to-region</span>' in a cloned indirect buffer in the other window.
The indirect buffer is named the same as the current buffer, except:

 * It is prefixed by the value of option `<span class="constant important">ni-buf-name-prefix</span>'.
 * It is suffixed by ` | TEXT', where TEXT is the region text,
   filtered by collapsing whitespace and (for Emacs 24.4+) removing
   invisible text.  (Actually, option `<span class="constant important">ni-buf-name-separator</span>' prefixes
   TEXT.  \" | \" is the default value of this option.)

However, the buffer name is in any case truncated at
`<span class="constant important">ni-narrowed-buf-name-max</span>' chars.

Non-interactively:
START and END are the region beginning and end.
HERE is where to place the cursor, relative to START.
TEXT is prefixed by `<span class="constant important">ni-buf-name-separator</span>' and appended to the
 original buffer name, which is appended to `<span class="constant important">ni-buf-name-prefix</span>' to
 name the new buffer.
If FULL-NAME is a string then it is used as the complete indirect
buffer name.  (TEXT is then ignored.)

See `<span class="constant important">clone-indirect-buffer</span>'."</span>
  (interactive
   (list (region-beginning) (region-end) (point) (and current-prefix-arg  (read-string <span class="string">"Buffer name: "</span>)) nil 'MSGP))
  (<span class="keyword elisp">if</span> (and (= start end)  msgp)
      (message <span class="string">"Region is empty"</span>)
    (deactivate-mark)
    (<span class="keyword elisp">let</span>* ((buf  (or full-name  text  (ni-buffer-substring-collapsed-visible start end)))
           (buf  (or full-name  (concat ni-buf-name-prefix (buffer-name) ni-buf-name-separator buf)))
           (buf  (or full-name  (substring buf 0 (min (length buf) ni-narrowed-buf-name-max))))
           (buf   (clone-indirect-buffer buf nil)))
      (<span class="keyword elisp">with-current-buffer</span> buf (narrow-to-region start end) (goto-char here))
      (pop-to-buffer buf)
      (setq mode-line-buffer-identification  (list (propertize (car mode-line-buffer-identification)
                                                               'face 'ni-mode-line-buffer-id))))))

(<span class="keyword">defun</span> <span class="function">ni-buffer-substring-collapsed-visible</span> (start end)
  <span class="string">"Return a suitable string based on buffer content between START and END.
Whitespace is collapsed.  And if you use library `subr+.el' then
invisible text is removed."</span>
  (replace-regexp-in-string <span class="string">"\\s-+"</span> <span class="string">" "</span>
                            (replace-regexp-in-string
                             <span class="string">"\\`\\s-+\\|\\s-+\\'"</span> <span class="string">""</span>
                             (<span class="keyword elisp">if</span> (not (<span class="keyword">require</span> '<span class="constant">subr+</span> nil t))
                                 (buffer-substring-no-properties start end)
                               (<span class="keyword elisp">let</span>* ((filter-buffer-substring-function
                                       (<span class="keyword elisp">lambda</span> (beg end _delete) <span class="comment">; Remove invisible text.</span>
                                         (<span class="keyword elisp">let</span> ((strg  (buffer-substring-of-visible beg end)))
                                           (set-text-properties 0 (length strg) () strg)
                                           strg)))
                                      <span class="comment">;; Older Emacs versions use `<span class="constant important">filter-buffer-substring-functions</span>',</span>
                                      <span class="comment">;; not `<span class="constant important">filter-buffer-substring-function</span>'.</span>
                                      (filter-buffer-substring-functions
                                       (list (<span class="keyword elisp">lambda</span> (fun beg end del)
                                               (funcall filter-buffer-substring-function beg end del)))))
                                 (filter-buffer-substring start end))))))

<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">ni-narrow-to-page-indirect-other-window</span> (<span class="type">&amp;optional</span> arg)
  <span class="string">"`<span class="constant important">narrow-to-page</span>' in a cloned indirect buffer in the other window.

See `<span class="constant important">clone-indirect-buffer</span>'."</span>
  (interactive <span class="string">"P"</span>)
  (<span class="keyword elisp">let</span> ((buf  (clone-indirect-buffer nil nil)))
    (<span class="keyword elisp">with-current-buffer</span> buf (narrow-to-page arg)) (pop-to-buffer buf)))

<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>

(<span class="keyword">provide</span> '<span class="constant">narrow-indirect</span>)

<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;; narrow-indirect.el ends here</span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="translation bar"><br />  <a href="https://www.emacswiki.org/emacs?action=translate;id=narrow-indirect.el;missing=de_es_fr_it_ja_ko_pt_ru_se_uk_zh" rel="nofollow" class="translation new">Add Translation</a></span><div class="edit bar"><a class="comment local edit" accesskey="c" href="https://www.emacswiki.org/emacs/Comments_on_narrow-indirect.el">Talk</a> <a class="password" href="https://www.emacswiki.org/emacs?action=password" rel="nofollow">This page is read-only</a> <a class="history" rel="nofollow" href="https://www.emacswiki.org/emacs?action=history;id=narrow-indirect.el">View other revisions</a> <a rel="nofollow" href="https://www.emacswiki.org/emacs?action=admin;id=narrow-indirect.el" class="admin">Administration</a></div><div class="time">Last edited 2015-12-31 23:39 UTC by <a href="https://www.emacswiki.org/emacs/DrewAdams" title="127.0.0.1" class="author">DrewAdams</a> <a class="diff" href="https://www.emacswiki.org/emacs?action=browse;diff=2;id=narrow-indirect.el" rel="nofollow">(diff)</a></div><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="https://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="https://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="https://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="https://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="https://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="https://creativecommons.org/">CreativeCommons</a>
<a href="https://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
<p class="legal" style="padding-top: 0.5em">Please note our <a href="Privacy">Privacy Statement</a>.</p>
</div>
</body>
</html>
