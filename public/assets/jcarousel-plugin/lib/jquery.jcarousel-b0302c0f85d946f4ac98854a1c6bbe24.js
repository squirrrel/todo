!function(t){var i={vertical:!1,rtl:!1,start:1,offset:1,size:2,scroll:2,visible:1,animation:"normal",easing:"swing",auto:0,wrap:null,initCallback:null,setupCallback:null,reloadCallback:null,itemLoadCallback:null,itemFirstInCallback:null,itemFirstOutCallback:null,itemLastInCallback:null,itemLastOutCallback:null,itemVisibleInCallback:null,itemVisibleOutCallback:null,animationStepCallback:null,buttonNextHTML:"<div></div>",buttonPrevHTML:"<div></div>",buttonNextEvent:"click",buttonPrevEvent:"click",buttonNextCallback:null,buttonPrevCallback:null,itemFallbackDimension:null},s=!1;t(window).bind("load.jcarousel",function(){s=!0}),t.jcarousel=function(l,o){this.options=t.extend({},i,o||{}),this.locked=!1,this.autoStopped=!1,this.container=null,this.clip=null,this.list=null,this.buttonNext=null,this.buttonPrev=null,this.buttonNextState=null,this.buttonPrevState=null,o&&void 0!==o.rtl||(this.options.rtl="rtl"==(t(l).attr("dir")||t("html").attr("dir")||"").toLowerCase()),this.wh=this.options.vertical?"height":"width",this.lt=this.options.vertical?"top":this.options.rtl?"right":"left";for(var e="",a=l.className.split(" "),h=0;h<a.length;h++)if(-1!=a[h].indexOf("jcarousel-skin")){t(l).removeClass(a[h]),e=a[h];break}"UL"==l.nodeName.toUpperCase()||"OL"==l.nodeName.toUpperCase()?(this.list=t(l),this.clip=this.list.parents(".jcarousel-clip"),this.container=this.list.parents(".jcarousel-container")):(this.container=t(l),this.list=this.container.find("ul,ol").eq(0),this.clip=this.container.find(".jcarousel-clip")),0===this.clip.size()&&(this.clip=this.list.wrap("<div></div>").parent()),0===this.container.size()&&(this.container=this.clip.wrap("<div></div>").parent()),""!==e&&-1==this.container.parent()[0].className.indexOf("jcarousel-skin")&&this.container.wrap('<div class=" '+e+'"></div>'),this.buttonPrev=t(".jcarousel-prev",this.container),0===this.buttonPrev.size()&&null!==this.options.buttonPrevHTML&&(this.buttonPrev=t(this.options.buttonPrevHTML).appendTo(this.container)),this.buttonPrev.addClass(this.className("jcarousel-prev")),this.buttonNext=t(".jcarousel-next",this.container),0===this.buttonNext.size()&&null!==this.options.buttonNextHTML&&(this.buttonNext=t(this.options.buttonNextHTML).appendTo(this.container)),this.buttonNext.addClass(this.className("jcarousel-next")),this.clip.addClass(this.className("jcarousel-clip")).css({position:"relative"}),this.list.addClass(this.className("jcarousel-list")).css({overflow:"hidden",position:"relative",top:0,margin:0,padding:0}).css(this.options.rtl?"right":"left",0),this.container.addClass(this.className("jcarousel-container")).css({position:"relative"}),!this.options.vertical&&this.options.rtl&&this.container.addClass("jcarousel-direction-rtl").attr("dir","rtl");var r=null!==this.options.visible?Math.ceil(this.clipping()/this.options.visible):null,c=this.list.children("li"),u=this;if(c.size()>0){var p=0,d=this.options.offset;c.each(function(){u.format(this,d++),p+=u.dimension(this,r)}),this.list.css(this.wh,p+100+"px"),o&&void 0!==o.size||(this.options.size=c.size())}this.container.css("display","block"),this.buttonNext.css("display","block"),this.buttonPrev.css("display","block"),this.funcNext=function(){return u.next(),!1},this.funcPrev=function(){return u.prev(),!1},this.funcResize=function(){u.resizeTimer&&clearTimeout(u.resizeTimer),u.resizeTimer=setTimeout(function(){u.reload()},100)},null!==this.options.initCallback&&this.options.initCallback(this,"init"),!s&&n.isSafari()?(this.buttons(!1,!1),t(window).bind("load.jcarousel",function(){u.setup()})):this.setup()};var n=t.jcarousel;n.fn=n.prototype={jcarousel:"0.2.9"},n.fn.extend=n.extend=t.extend,n.fn.extend({setup:function(){if(this.first=null,this.last=null,this.prevFirst=null,this.prevLast=null,this.animating=!1,this.timer=null,this.resizeTimer=null,this.tail=null,this.inTail=!1,!this.locked){this.list.css(this.lt,this.pos(this.options.offset)+"px");var i=this.pos(this.options.start,!0);this.prevFirst=this.prevLast=null,this.animate(i,!1),t(window).unbind("resize.jcarousel",this.funcResize).bind("resize.jcarousel",this.funcResize),null!==this.options.setupCallback&&this.options.setupCallback(this)}},reset:function(){this.list.empty(),this.list.css(this.lt,"0px"),this.list.css(this.wh,"10px"),null!==this.options.initCallback&&this.options.initCallback(this,"reset"),this.setup()},reload:function(){if(null!==this.tail&&this.inTail&&this.list.css(this.lt,n.intval(this.list.css(this.lt))+this.tail),this.tail=null,this.inTail=!1,null!==this.options.reloadCallback&&this.options.reloadCallback(this),null!==this.options.visible){var t=this,i=Math.ceil(this.clipping()/this.options.visible),s=0,l=0;this.list.children("li").each(function(n){s+=t.dimension(this,i),n+1<t.first&&(l=s)}),this.list.css(this.wh,s+"px"),this.list.css(this.lt,-l+"px")}this.scroll(this.first,!1)},lock:function(){this.locked=!0,this.buttons()},unlock:function(){this.locked=!1,this.buttons()},size:function(t){return void 0!==t&&(this.options.size=t,this.locked||this.buttons()),this.options.size},has:function(t,i){void 0!==i&&i||(i=t),null!==this.options.size&&i>this.options.size&&(i=this.options.size);for(var s=t;i>=s;s++){var n=this.get(s);if(!n.length||n.hasClass("jcarousel-item-placeholder"))return!1}return!0},get:function(i){return t(">.jcarousel-item-"+i,this.list)},add:function(i,s){var l=this.get(i),o=0,e=t(s);if(0===l.length){var a,h=n.intval(i);for(l=this.create(i);;)if(a=this.get(--h),0>=h||a.length){0>=h?this.list.prepend(l):a.after(l);break}}else o=this.dimension(l);"LI"==e.get(0).nodeName.toUpperCase()?(l.replaceWith(e),l=e):l.empty().append(s),this.format(l.removeClass(this.className("jcarousel-item-placeholder")),i);var r=null!==this.options.visible?Math.ceil(this.clipping()/this.options.visible):null,c=this.dimension(l,r)-o;return i>0&&i<this.first&&this.list.css(this.lt,n.intval(this.list.css(this.lt))-c+"px"),this.list.css(this.wh,n.intval(this.list.css(this.wh))+c+"px"),l},remove:function(t){var i=this.get(t);if(i.length&&!(t>=this.first&&t<=this.last)){var s=this.dimension(i);t<this.first&&this.list.css(this.lt,n.intval(this.list.css(this.lt))+s+"px"),i.remove(),this.list.css(this.wh,n.intval(this.list.css(this.wh))-s+"px")}},next:function(){null===this.tail||this.inTail?this.scroll("both"!=this.options.wrap&&"last"!=this.options.wrap||null===this.options.size||this.last!=this.options.size?this.first+this.options.scroll:1):this.scrollTail(!1)},prev:function(){null!==this.tail&&this.inTail?this.scrollTail(!0):this.scroll("both"!=this.options.wrap&&"first"!=this.options.wrap||null===this.options.size||1!=this.first?this.first-this.options.scroll:this.options.size)},scrollTail:function(t){if(!this.locked&&!this.animating&&this.tail){this.pauseAuto();var i=n.intval(this.list.css(this.lt));i=t?i+this.tail:i-this.tail,this.inTail=!t,this.prevFirst=this.first,this.prevLast=this.last,this.animate(i)}},scroll:function(t,i){this.locked||this.animating||(this.pauseAuto(),this.animate(this.pos(t),i))},pos:function(t,i){var s=n.intval(this.list.css(this.lt));if(this.locked||this.animating)return s;"circular"!=this.options.wrap&&(t=1>t?1:this.options.size&&t>this.options.size?this.options.size:t);for(var l,o=this.first>t,e="circular"!=this.options.wrap&&this.first<=1?1:this.first,a=o?this.get(e):this.get(this.last),h=o?e:e-1,r=null,c=0,u=!1,p=0;o?--h>=t:++h<t;)r=this.get(h),u=!r.length,0===r.length&&(r=this.create(h).addClass(this.className("jcarousel-item-placeholder")),a[o?"before":"after"](r),null!==this.first&&"circular"==this.options.wrap&&null!==this.options.size&&(0>=h||h>this.options.size)&&(l=this.get(this.index(h)),l.length&&(r=this.add(h,l.clone(!0))))),a=r,p=this.dimension(r),u&&(c+=p),null!==this.first&&("circular"==this.options.wrap||h>=1&&(null===this.options.size||h<=this.options.size))&&(s=o?s+p:s-p);var d=this.clipping(),f=[],v=0,b=0;for(a=this.get(t-1),h=t;++v;){if(r=this.get(h),u=!r.length,0===r.length&&(r=this.create(h).addClass(this.className("jcarousel-item-placeholder")),0===a.length?this.list.prepend(r):a[o?"before":"after"](r),null!==this.first&&"circular"==this.options.wrap&&null!==this.options.size&&(0>=h||h>this.options.size)&&(l=this.get(this.index(h)),l.length&&(r=this.add(h,l.clone(!0))))),a=r,p=this.dimension(r),0===p)throw new Error("jCarousel: No width/height set for items. This will cause an infinite loop. Aborting...");if("circular"!=this.options.wrap&&null!==this.options.size&&h>this.options.size?f.push(r):u&&(c+=p),b+=p,b>=d)break;h++}for(var m=0;m<f.length;m++)f[m].remove();c>0&&(this.list.css(this.wh,this.dimension(this.list)+c+"px"),o&&(s-=c,this.list.css(this.lt,n.intval(this.list.css(this.lt))-c+"px")));var g=t+v-1;if("circular"!=this.options.wrap&&this.options.size&&g>this.options.size&&(g=this.options.size),h>g)for(v=0,h=g,b=0;++v&&(r=this.get(h--),r.length)&&(b+=this.dimension(r),!(b>=d)););var k=g-v+1;if("circular"!=this.options.wrap&&1>k&&(k=1),this.inTail&&o&&(s+=this.tail,this.inTail=!1),this.tail=null,"circular"!=this.options.wrap&&g==this.options.size&&g-v+1>=1){var w=n.intval(this.get(g).css(this.options.vertical?"marginBottom":"marginRight"));b-w>d&&(this.tail=b-d-w)}for(i&&t===this.options.size&&this.tail&&(s-=this.tail,this.inTail=!0);t-->k;)s+=this.dimension(this.get(t));return this.prevFirst=this.first,this.prevLast=this.last,this.first=k,this.last=g,s},animate:function(i,s){if(!this.locked&&!this.animating){this.animating=!0;var n=this,l=function(){if(n.animating=!1,0===i&&n.list.css(n.lt,0),!n.autoStopped&&("circular"==n.options.wrap||"both"==n.options.wrap||"last"==n.options.wrap||null===n.options.size||n.last<n.options.size||n.last==n.options.size&&null!==n.tail&&!n.inTail)&&n.startAuto(),n.buttons(),n.notify("onAfterAnimation"),"circular"==n.options.wrap&&null!==n.options.size)for(var t=n.prevFirst;t<=n.prevLast;t++)null===t||t>=n.first&&t<=n.last||!(1>t||t>n.options.size)||n.remove(t)};if(this.notify("onBeforeAnimation"),this.options.animation&&s!==!1){var o=this.options.vertical?{top:i}:this.options.rtl?{right:i}:{left:i},e={duration:this.options.animation,easing:this.options.easing,complete:l};t.isFunction(this.options.animationStepCallback)&&(e.step=this.options.animationStepCallback),this.list.animate(o,e)}else this.list.css(this.lt,i+"px"),l()}},startAuto:function(t){if(void 0!==t&&(this.options.auto=t),0===this.options.auto)return this.stopAuto();if(null===this.timer){this.autoStopped=!1;var i=this;this.timer=window.setTimeout(function(){i.next()},1e3*this.options.auto)}},stopAuto:function(){this.pauseAuto(),this.autoStopped=!0},pauseAuto:function(){null!==this.timer&&(window.clearTimeout(this.timer),this.timer=null)},buttons:function(t,i){null==t&&(t=!this.locked&&0!==this.options.size&&(this.options.wrap&&"first"!=this.options.wrap||null===this.options.size||this.last<this.options.size),this.locked||this.options.wrap&&"first"!=this.options.wrap||null===this.options.size||!(this.last>=this.options.size)||(t=null!==this.tail&&!this.inTail)),null==i&&(i=!this.locked&&0!==this.options.size&&(this.options.wrap&&"last"!=this.options.wrap||this.first>1),this.locked||this.options.wrap&&"last"!=this.options.wrap||null===this.options.size||1!=this.first||(i=null!==this.tail&&this.inTail));var s=this;this.buttonNext.size()>0?(this.buttonNext.unbind(this.options.buttonNextEvent+".jcarousel",this.funcNext),t&&this.buttonNext.bind(this.options.buttonNextEvent+".jcarousel",this.funcNext),this.buttonNext[t?"removeClass":"addClass"](this.className("jcarousel-next-disabled")).attr("disabled",t?!1:!0),null!==this.options.buttonNextCallback&&this.buttonNext.data("jcarouselstate")!=t&&this.buttonNext.each(function(){s.options.buttonNextCallback(s,this,t)}).data("jcarouselstate",t)):null!==this.options.buttonNextCallback&&this.buttonNextState!=t&&this.options.buttonNextCallback(s,null,t),this.buttonPrev.size()>0?(this.buttonPrev.unbind(this.options.buttonPrevEvent+".jcarousel",this.funcPrev),i&&this.buttonPrev.bind(this.options.buttonPrevEvent+".jcarousel",this.funcPrev),this.buttonPrev[i?"removeClass":"addClass"](this.className("jcarousel-prev-disabled")).attr("disabled",i?!1:!0),null!==this.options.buttonPrevCallback&&this.buttonPrev.data("jcarouselstate")!=i&&this.buttonPrev.each(function(){s.options.buttonPrevCallback(s,this,i)}).data("jcarouselstate",i)):null!==this.options.buttonPrevCallback&&this.buttonPrevState!=i&&this.options.buttonPrevCallback(s,null,i),this.buttonNextState=t,this.buttonPrevState=i},notify:function(t){var i=null===this.prevFirst?"init":this.prevFirst<this.first?"next":"prev";this.callback("itemLoadCallback",t,i),this.prevFirst!==this.first&&(this.callback("itemFirstInCallback",t,i,this.first),this.callback("itemFirstOutCallback",t,i,this.prevFirst)),this.prevLast!==this.last&&(this.callback("itemLastInCallback",t,i,this.last),this.callback("itemLastOutCallback",t,i,this.prevLast)),this.callback("itemVisibleInCallback",t,i,this.first,this.last,this.prevFirst,this.prevLast),this.callback("itemVisibleOutCallback",t,i,this.prevFirst,this.prevLast,this.first,this.last)},callback:function(i,s,n,l,o,e,a){if(null!=this.options[i]&&("object"==typeof this.options[i]||"onAfterAnimation"==s)){var h="object"==typeof this.options[i]?this.options[i][s]:this.options[i];if(t.isFunction(h)){var r=this;if(void 0===l)h(r,n,s);else if(void 0===o)this.get(l).each(function(){h(r,this,l,n,s)});else for(var c=function(t){r.get(t).each(function(){h(r,this,t,n,s)})},u=l;o>=u;u++)null===u||u>=e&&a>=u||c(u)}}},create:function(t){return this.format("<li></li>",t)},format:function(i,s){i=t(i);for(var n=i.get(0).className.split(" "),l=0;l<n.length;l++)-1!=n[l].indexOf("jcarousel-")&&i.removeClass(n[l]);return i.addClass(this.className("jcarousel-item")).addClass(this.className("jcarousel-item-"+s)).css({"float":this.options.rtl?"right":"left","list-style":"none"}).attr("jcarouselindex",s),i},className:function(t){return t+" "+t+(this.options.vertical?"-vertical":"-horizontal")},dimension:function(i,s){var l=t(i);if(null==s)return this.options.vertical?l.innerHeight()+n.intval(l.css("margin-top"))+n.intval(l.css("margin-bottom"))+n.intval(l.css("border-top-width"))+n.intval(l.css("border-bottom-width"))||n.intval(this.options.itemFallbackDimension):l.innerWidth()+n.intval(l.css("margin-left"))+n.intval(l.css("margin-right"))+n.intval(l.css("border-left-width"))+n.intval(l.css("border-right-width"))||n.intval(this.options.itemFallbackDimension);var o=this.options.vertical?s-n.intval(l.css("marginTop"))-n.intval(l.css("marginBottom")):s-n.intval(l.css("marginLeft"))-n.intval(l.css("marginRight"));return t(l).css(this.wh,o+"px"),this.dimension(l)},clipping:function(){return this.options.vertical?this.clip[0].offsetHeight-n.intval(this.clip.css("borderTopWidth"))-n.intval(this.clip.css("borderBottomWidth")):this.clip[0].offsetWidth-n.intval(this.clip.css("borderLeftWidth"))-n.intval(this.clip.css("borderRightWidth"))},index:function(t,i){return null==i&&(i=this.options.size),Math.round(((t-1)/i-Math.floor((t-1)/i))*i)+1}}),n.extend({defaults:function(s){return t.extend(i,s||{})},intval:function(t){return t=parseInt(t,10),isNaN(t)?0:t},windowLoaded:function(){s=!0},isSafari:function(){var t=navigator.userAgent.toLowerCase(),i=/(chrome)[ \/]([\w.]+)/.exec(t)||/(webkit)[ \/]([\w.]+)/.exec(t)||[],s=i[1]||"";return"webkit"===s}}),t.fn.jcarousel=function(i){if("string"==typeof i){var s=t(this).data("jcarousel"),l=Array.prototype.slice.call(arguments,1);return s[i].apply(s,l)}return this.each(function(){var s=t(this).data("jcarousel");s?(i&&t.extend(s.options,i),s.reload()):t(this).data("jcarousel",new n(this,i))})}}(jQuery);