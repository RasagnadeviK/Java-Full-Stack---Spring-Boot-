<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<head>
<meta charset="ISO-8859-1">
<title>Login-Precious Paw</title>
<%@ include file="components/common_cs_js.jsp"%>
</head>
<body>
  <%@ include file="components/navbar.jsp"%>
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header custom-bg text-white text-center">
            <h5 class="modal-title">MY CART</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
      if(user!=null)
      {
    	  List<Cart> l=new CartDaoImp().getCartByUserId(user.getUserId());
    	 
     %>
      <div class="modal-body">
        
        <%
            if(l.isEmpty())
            {
        %>
        <div class="text-center">
        <h1>CART IS EMPTY!!</h1>
        <hr>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        <%
            }
        
            else
            {
            	
            	
        %>
        <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Product Image</th>
      <th scope="col">Product Title</th>    
      <th scope="col">Product Description</th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  
 
  
  <tbody>
   <%
      CartDaoImp ctdao=new CartDaoImp();
      
   %>
  
   <%
      for(Cart c:l)
      {
    	  int productId=c.getProductId();
    	  Product p=new ProductDaoImp().getProductById(productId);
   %>
    <tr class="text-center">
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="productImages/<%=p.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getProductTitle() %></td>
      <td class="mid-align"><%=p.getProductDescription() %></td>
      <td class="mid-align"><%=c.getQuantity() %></td>
      <td class="mid-align"><%=c.getPrice() %></td>
      <td class="mid-align"><a href="CartServlet?cartId=<%=c.getCartId()%>&action=delete"><button type="button" class="btn btn-danger">Remove</button></a></td>
    </tr>
    <%
      }
    %>
  </tbody>
 
  
</table>
</div>
<hr>

<div class="text-right">
    <p style="font-size:25px;"><b>Total Price :&#8377;<%=new CartDaoImp().totalPriceFromCart(user.getUserId()) %>/- </b></p> 
</div>
<hr>
<div class="row">
      <form action="authorize_payment" method="post">
          <input type="hidden" name="userId" value="<%=user.getUserId()%>">
          <input type="submit" class="btn custom-bg text-light ml-5" value="Order with Pay Pal">
      </form>
     
</div>
<div class="row">
    <form action="place_cod_order" method="post">
        <input type="hidden" name="userId" value="<%=user.getUserId()%>">
        <button type="submit" class="btn custom-bg text-light ml-5">Order with Cash on Delivery</button>
    </form>
    <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Close</button>
</div>

       <%
            }
       %>
         
      </div>
  <%
           
      }
  %>
    </div>
  </div>
</body>
</html>