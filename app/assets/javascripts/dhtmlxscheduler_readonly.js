/*
@license
dhtmlxScheduler v.4.3.1 

This software is covered by GPL license. You also can obtain Commercial or Enterprise license to use it in non-GPL project - please contact sales@dhtmlx.com. Usage without proper license is prohibited.

(c) Dinamenta, UAB.
*/
scheduler.attachEvent("onTemplatesReady",function(){function e(e,t,a,r){for(var n=t.getElementsByTagName(e),i=a.getElementsByTagName(e),l=i.length-1;l>=0;l--){var a=i[l];if(r){var d=document.createElement("SPAN");d.className="dhx_text_disabled",d.innerHTML=r(n[l]),a.parentNode.insertBefore(d,a),a.parentNode.removeChild(a)}else a.disabled=!0,t.checked&&(a.checked=!0)}}var t=scheduler.config.lightbox.sections.slice(),a=scheduler.config.buttons_left.slice(),r=scheduler.config.buttons_right.slice();scheduler.attachEvent("onBeforeLightbox",function(e){
if(this.config.readonly_form||this.getEvent(e).readonly){this.config.readonly_active=!0;for(var n=0;n<this.config.lightbox.sections.length;n++)this.config.lightbox.sections[n].focus=!1}else this.config.readonly_active=!1,scheduler.config.lightbox.sections=t.slice(),scheduler.config.buttons_left=a.slice(),scheduler.config.buttons_right=r.slice();var i=this.config.lightbox.sections;if(this.config.readonly_active){for(var n=0;n<i.length;n++)if("recurring"==i[n].type){this.config.readonly_active&&i.splice(n,1);

break}for(var l=["dhx_delete_btn","dhx_save_btn"],d=[scheduler.config.buttons_left,scheduler.config.buttons_right],n=0;n<l.length;n++)for(var s=l[n],o=0;o<d.length;o++){for(var _=d[o],c=-1,u=0;u<_.length;u++)if(_[u]==s){c=u;break}-1!=c&&_.splice(c,1)}}return this.resetLightbox(),!0});var n=scheduler._fill_lightbox;scheduler._fill_lightbox=function(){var t=this.getLightbox();this.config.readonly_active&&(t.style.visibility="hidden",t.style.display="block");var a=n.apply(this,arguments);if(this.config.readonly_active&&(t.style.visibility="",
t.style.display="none"),this.config.readonly_active){var r=this.getLightbox(),l=this._lightbox_r=r.cloneNode(!0);l.id=scheduler.uid(),e("textarea",r,l,function(e){return e.value}),e("input",r,l,!1),e("select",r,l,function(e){return e.options.length?e.options[Math.max(e.selectedIndex||0,0)].text:""}),r.parentNode.insertBefore(l,r),i.call(this,l),scheduler._lightbox&&scheduler._lightbox.parentNode.removeChild(scheduler._lightbox),this._lightbox=l,scheduler.config.drag_lightbox&&(l.firstChild.onmousedown=scheduler._ready_to_dnd),
this.setLightboxSize(),l.onclick=function(e){var t=e?e.target:event.srcElement;if(t.className||(t=t.previousSibling),t&&t.className)switch(t.className){case"dhx_cancel_btn":scheduler.callEvent("onEventCancel",[scheduler._lightbox_id]),scheduler._edit_stop_event(scheduler.getEvent(scheduler._lightbox_id),!1),scheduler.hide_lightbox()}}}return a};var i=scheduler.showCover;scheduler.showCover=function(){this.config.readonly_active||i.apply(this,arguments)};var l=scheduler.hide_lightbox;scheduler.hide_lightbox=function(){
return this._lightbox_r&&(this._lightbox_r.parentNode.removeChild(this._lightbox_r),this._lightbox_r=this._lightbox=null),l.apply(this,arguments)}});