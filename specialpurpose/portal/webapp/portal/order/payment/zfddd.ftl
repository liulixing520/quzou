<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link type="text/css" rel="stylesheet" href="../images/zf/bootstrap.css" />
</head>

<body>
<div class="container" style="padding-top:80px;">
  <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
      <div class="panel panel-primary">
        <div class="panel-heading">
          <h3 class="panel-title">Card authentication</h3>
        </div>
        <div class="panel-body">
          <p class="text-center">Payment details</p>
          <ul>
            <li>Order 328552214_190115094233_128070_22877</li>
            <li>Card 444444******4448</li>
            <li>19420.39 RUR</li>
          </ul>
          <div class="alert alert-warning"> <strong>Attention!</strong> Enter the same CVC to get success or any other to get failure. </div>
          <form action="<@ofbizUrl>zfdddd</@ofbizUrl>" method="post" role="form">
            <input type="hidden" value="" name="PaReq">
            <input type="hidden" value="" name="MD">
            <input type="hidden" value="" name="TermUrl">
            <input type="hidden" value="1" name="answerType">
            <input type="text" autofocus="" required="" placeholder="CVC" name="answer" id="cvc" class="form-control">
            <button type="submit" class="btn btn-lg btn-primary btn-block" value="Post" id="submitcvc">Confirm</button>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-4"></div>
  </div>
</div>
</body>
</html>
