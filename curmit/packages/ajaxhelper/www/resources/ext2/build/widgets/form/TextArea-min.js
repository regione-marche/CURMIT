/*
 * Ext JS Library 2.0
 * Copyright(c) 2006-2007, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.form.TextArea=Ext.extend(Ext.form.TextField,{growMin:60,growMax:1000,growAppend:"&#160;\n&#160;",growPad:0,enterIsSpecial:false,preventScrollbars:false,onRender:function(B,A){if(!this.el){this.defaultAutoCreate={tag:"textarea",style:"width:100px;height:60px;",autocomplete:"off"}}Ext.form.TextArea.superclass.onRender.call(this,B,A);if(this.grow){this.textSizeEl=Ext.DomHelper.append(document.body,{tag:"pre",cls:"x-form-grow-sizer"});if(this.preventScrollbars){this.el.setStyle("overflow","hidden")}this.el.setHeight(this.growMin)}},onDestroy:function(){if(this.textSizeEl){Ext.removeNode(this.textSizeEl)}Ext.form.TextArea.superclass.onDestroy.call(this)},fireKey:function(A){if(A.isSpecialKey()&&(this.enterIsSpecial||(A.getKey()!=A.ENTER||A.hasModifier()))){this.fireEvent("specialkey",this,A)}},onKeyUp:function(A){if(!A.isNavKeyPress()||A.getKey()==A.ENTER){this.autoSize()}},autoSize:function(){if(!this.grow||!this.textSizeEl){return }var C=this.el;var A=C.dom.value;var D=this.textSizeEl;D.innerHTML="";D.appendChild(document.createTextNode(A));A=D.innerHTML;Ext.fly(D).setWidth(this.el.getWidth());if(A.length<1){A="&#160;&#160;"}else{if(Ext.isIE){A=A.replace(/\n/g,"<p>&#160;</p>")}A+=this.growAppend}D.innerHTML=A;var B=Math.min(this.growMax,Math.max(D.offsetHeight,this.growMin)+this.growPad);if(B!=this.lastHeight){this.lastHeight=B;this.el.setHeight(B);this.fireEvent("autosize",this,B)}}});Ext.reg("textarea",Ext.form.TextArea);