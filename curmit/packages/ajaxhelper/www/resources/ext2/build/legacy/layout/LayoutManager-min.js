/*
 * Ext JS Library 2.0
 * Copyright(c) 2006-2007, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.LayoutManager=function(A,B){Ext.LayoutManager.superclass.constructor.call(this);this.el=Ext.get(A);if(this.el.dom==document.body&&Ext.isIE&&!B.allowScroll){document.body.scroll="no"}else{if(this.el.dom!=document.body&&this.el.getStyle("position")=="static"){this.el.position("relative")}}this.id=this.el.id;this.el.addClass("x-layout-container");this.monitorWindowResize=true;this.regions={};this.addEvents({"layout":true,"regionresized":true,"regioncollapsed":true,"regionexpanded":true});this.updating=false;Ext.EventManager.onWindowResize(this.onWindowResize,this,true)};Ext.extend(Ext.LayoutManager,Ext.util.Observable,{isUpdating:function(){return this.updating},beginUpdate:function(){this.updating=true},endUpdate:function(A){this.updating=false;if(!A){this.layout()}},layout:function(){},onRegionResized:function(B,A){this.fireEvent("regionresized",B,A);this.layout()},onRegionCollapsed:function(A){this.fireEvent("regioncollapsed",A)},onRegionExpanded:function(A){this.fireEvent("regionexpanded",A)},getViewSize:function(){var A;if(this.el.dom!=document.body){A=this.el.getSize()}else{A={width:Ext.lib.Dom.getViewWidth(),height:Ext.lib.Dom.getViewHeight()}}A.width-=this.el.getBorderWidth("lr")-this.el.getPadding("lr");A.height-=this.el.getBorderWidth("tb")-this.el.getPadding("tb");return A},getEl:function(){return this.el},getRegion:function(A){return this.regions[A.toLowerCase()]},onWindowResize:function(){if(this.monitorWindowResize){this.layout()}}});