/**
 * ExecutePaymentServlet class - execute payment via PayPal.
 * @author Nam Ha Minh
 * @copyright https://codeJava.net
 */
package com.ecommerce.servlet;
 
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ecommerce.dao.CartDaoImp;
import com.ecommerce.dao.OrderDaoImp;
import com.ecommerce.dao.ProductDaoImp;
import com.ecommerce.paypal.PaymentServices;
import com.ecommerce.pojo.Cart;
import com.ecommerce.pojo.Order;
import com.ecommerce.pojo.Product;
import com.ecommerce.pojo.User;
import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
 
@WebServlet("/execute_payment")
public class ExecutePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public ExecutePaymentServlet() {
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        HttpSession session=request.getSession();
        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);
             
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
             
            User user=(User)session.getAttribute("active-user");
            int userId=user.getUserId();
			LocalDate date=LocalDate.now();
			String orderedDate=String.valueOf(date);
			OrderDaoImp od=new OrderDaoImp();
			CartDaoImp cd=new CartDaoImp();
			Order order=new Order();
			ProductDaoImp pd=new ProductDaoImp();
			
			List<Cart> cart=cd.getCartByUserId(userId);
		    for(Cart c:cart)
		    {
			    int productId=c.getProductId();
			    Product product=pd.getProductById(productId);
			    int productOldQuantity=product.getProductQuantity();
			    int updatedQuantity=productOldQuantity-c.getQuantity();
			    pd.updateQuantityAfterOrder(productId, updatedQuantity);
		  
			    order.setProdctId(productId);
		    	order.setUserId(userId);
		    	order.setQuantity(c.getQuantity());
		    	order.setPrice(c.getPrice());
		    	order.setOrderesDate(orderedDate);
		    	order.setDeliveryDate("0");
		    	od.addOrder(order);
		    		
		    }
		        cd.deleteCartByUserId(userId);
            
            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);  
 
            request.getRequestDispatcher("receipt.jsp").forward(request, response);
             
        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
 
}