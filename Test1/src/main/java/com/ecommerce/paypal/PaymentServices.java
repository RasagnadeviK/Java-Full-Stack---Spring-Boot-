package com.ecommerce.paypal;

import java.util.ArrayList;

import java.util.List;

import com.ecommerce.dao.CartDaoImp;
import com.ecommerce.dao.Helper;
import com.ecommerce.dao.ProductDaoImp;
import com.ecommerce.dao.UserDaoImp;
import com.ecommerce.pojo.Cart;
import com.ecommerce.pojo.Product;
import com.ecommerce.pojo.User;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

public class PaymentServices {
	private static final String CLIENT_ID = "ARYMZMXtb-H6R5updmjY7seD_UxK49blDeJXKfGhnPlQEAGlqI2pTdsMiq186swzmzxF257m2S5skljK";  // Enter your Paypal Client Id
	private static final String CLIENT_SECRET = "EIJDm8oAEWT7lZ6jVOtgvNgtxUD1_fWpBiET05BOHMnlYPcf4nDcQhDyKpCr3H-CikVZiTiFTlyXt2Fd"; // Enter your Secret Key
	private static final String MODE = "sandbox";

	public String authorizePayment(List<Cart> listOfProductInCart) throws PayPalRESTException {

		Payer payer = getPayerInformation(listOfProductInCart.get(0));
		RedirectUrls redirectUrls = getRedirectURLs();
		List<Transaction> listTransaction = getTransactionInformation(listOfProductInCart);

		Payment requestPayment = new Payment();
		requestPayment.setTransactions(listTransaction);
		requestPayment.setRedirectUrls(redirectUrls);
		requestPayment.setPayer(payer);
		requestPayment.setIntent("authorize");

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
		Payment approvedPayment = requestPayment.create(apiContext);
		return getApprovalLink(approvedPayment);

	}

	private Payer getPayerInformation(Cart userFromCart) {
		User user=new UserDaoImp().getUserByUserId(userFromCart.getUserId());
		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");

		PayerInfo payerInfo = new PayerInfo();
		payerInfo.setFirstName(user.getUserName()).setEmail(user.getUserEmail()).setLastName("Ali");

		payer.setPayerInfo(payerInfo);

		return payer;
	}

	private RedirectUrls getRedirectURLs() {
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl("http://localhost:8084/Test1/cancel.jsp");
		redirectUrls.setReturnUrl("http://localhost:8084/Test1/review_payment");

		return redirectUrls;
	}

	private List<Transaction> getTransactionInformation(List<Cart> cartDetail) {
		
		List<Transaction> listTransaction = new ArrayList<>();
//		String shippingAddress=new UserDaoImp().getUserByUserId(cartDetail.get(0).getUserId()).getUserAddress();
		Details details = new Details();
		details.setShipping("40");
        details.setSubtotal(String.valueOf(new CartDaoImp().totalPriceFromCart(cartDetail.get(0).getUserId())));
        details.setTax("10");
        System.out.println("total from cart :"+String.valueOf(new CartDaoImp().totalPriceFromCart(cartDetail.get(0).getUserId())));
        int total=40+10+new CartDaoImp().totalPriceFromCart(cartDetail.get(0).getUserId());
        System.out.println("Toal: "+total);
		Amount amount = new Amount();
		amount.setCurrency("USD");
		amount.setTotal(String.valueOf(total));
		amount.setDetails(details);

		Transaction transaction = new Transaction();
		transaction.setAmount(amount);
		transaction.setDescription("Ecommerce");

		ItemList itemList = new ItemList();
		List<Item> items = new ArrayList<>();

		for(Cart c: cartDetail)
		{
			Product p=new ProductDaoImp().getProductById(c.getProductId());
			Item item = new Item();
			item.setCurrency("USD");
			item.setName(p.getProductTitle());
			item.setQuantity(String.valueOf(c.getQuantity()));
			item.setPrice(String.valueOf(Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount())));

			items.add(item);
		}
		
		itemList.setItems(items);
		transaction.setItemList(itemList);

		
		listTransaction.add(transaction);

		return listTransaction;
	}

	private String getApprovalLink(Payment approvedPayment) {
		List<Links> links = approvedPayment.getLinks();
		String approvalLink = null;

		for (Links link : links) {
			if (link.getRel().equalsIgnoreCase("approval_url")) {
				approvalLink = link.getHref();
				break;
			}
		}
		System.out.println(approvalLink);
		return approvalLink;
	}

	public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
		return Payment.get(apiContext, paymentId);
	}

	public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
		PaymentExecution paymentExecution = new PaymentExecution();
		paymentExecution.setPayerId(payerId);

		Payment payment = new Payment().setId(paymentId);

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

		return payment.execute(apiContext, paymentExecution);
	}

}
