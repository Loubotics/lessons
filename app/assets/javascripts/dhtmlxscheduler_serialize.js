/*
dhtmlxScheduler v.4.1.0 Stardard

This software is covered by GPL license. You also can obtain Commercial or Enterprise license to use it in non-GPL project - please contact sales@dhtmlx.com. Usage without proper license is prohibited.

(c) Dinamenta, UAB.
*/
scheduler._get_serializable_data=function(){var e={};for(var t in this._events){var r=this._events[t];-1==r.id.toString().indexOf("#")&&(e[r.id]=r)}return e},scheduler.data_attributes=function(){var e=[],t=scheduler.templates.xml_format,r=this._get_serializable_data();for(var s in r){var a=r[s];for(var n in a)"_"!=n.substr(0,1)&&e.push([n,"start_date"==n||"end_date"==n?t:null]);break}return e},scheduler.toXML=function(e){var t=[],r=this.data_attributes(),s=this._get_serializable_data();for(var a in s){var n=s[a];
t.push("<event>");for(var i=0;i<r.length;i++)t.push("<"+r[i][0]+"><![CDATA["+(r[i][1]?r[i][1](n[r[i][0]]):n[r[i][0]])+"]]></"+r[i][0]+">");t.push("</event>")}return(e||"")+"<data>"+t.join("\n")+"</data>"},scheduler._serialize_json_value=function(e){return null===e||"boolean"==typeof e?e=""+e:(e||0===e||(e=""),e='"'+e.toString().replace(/\n/g,"").replace(/\\/g,"\\\\").replace(/\"/g,'\\"')+'"'),e},scheduler.toJSON=function(){var e=[],t="",r=this.data_attributes(),s=this._get_serializable_data();for(var a in s){for(var n=s[a],i=[],d=0;d<r.length;d++)t=r[d][1]?r[d][1](n[r[d][0]]):n[r[d][0]],i.push(' "'+r[d][0]+'": '+this._serialize_json_value(t));
e.push("{"+i.join(",")+"}")}return"["+e.join(",\n")+"]"},scheduler.toICal=function(e){var t="BEGIN:VCALENDAR\nVERSION:2.0\nPRODID:-//dhtmlXScheduler//NONSGML v2.2//EN\nDESCRIPTION:",r="END:VCALENDAR",s=scheduler.date.date_to_str("%Y%m%dT%H%i%s"),a=scheduler.date.date_to_str("%Y%m%d"),n=[],i=this._get_serializable_data();for(var d in i){var l=i[d];n.push("BEGIN:VEVENT"),n.push(l._timed&&(l.start_date.getHours()||l.start_date.getMinutes())?"DTSTART:"+s(l.start_date):"DTSTART:"+a(l.start_date)),n.push(l._timed&&(l.end_date.getHours()||l.end_date.getMinutes())?"DTEND:"+s(l.end_date):"DTEND:"+a(l.end_date)),n.push("SUMMARY:"+l.text),n.push("END:VEVENT")
}return t+(e||"")+"\n"+n.join("\n")+"\n"+r};
