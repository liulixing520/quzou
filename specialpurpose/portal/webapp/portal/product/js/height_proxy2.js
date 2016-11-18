try{document.domain="aliexpress.com";}catch(e){}
window.onload = function(){
	var param = window.location.hash.split('|');
	var id = param[0];
	//this.parent.parent.setFrameHeight(id.substr(1, id.length-1), param[1]);
    if(!this.parent.parent.document.getElementById(id.substr(1, id.length-1))){ 
		var frame=this.parent.parent.document.getElementById(id.substr(1, id.length-1));
	}else{ 
		var frame = this.parent.parent.document.getElementById(id.substr(1, id.length-1)).getElementsByTagName('iframe')[0];		
	}

	if(!-[1,]) {
		// if broswer is ie
		frame.height = parseInt(param[1]) + 20;
	}
	else {
		// if broswer is not ie
		if(!frame){ return; }
		frame.height = parseInt(param[1]) + 20;
	}
	frame.setAttribute('sbHeight',frame.height);
	
}