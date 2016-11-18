<html>
<body>
<h1>获得服务器更新</h1>
<div id="result"></div>

<script>
if(typeof(EventSource)!=="undefined")
  {   
      var source=new EventSource("http://localhost:8080/ofbiztools/control/posTime");
      source.onmessage=function(event){
        document.getElementById("result").innerHTML+=event.data + "<br />";
      };
  }else{
      document.getElementById("result").innerHTML="Sorry, your browser does not support server-sent events...";
  }
  
  
  
      
// 发送消息  
function sendMsg() {  
    var data = document.getElementById('msgSendBox').value;  
    
    $.ajax({
                type: "POST",
                url: "/ofbiztools/control/posTime?sss=444",
                success: function(r){
                    
                }
            });
            
    document.getElementById('msgSendBox').value = '';  
      
}  
</script> 



</body>
</html>
