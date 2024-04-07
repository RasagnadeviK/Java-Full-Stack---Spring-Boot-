package com.ecommerce.dao;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
public class Helper
{
    public static String get10Words(String productDescription)
    {
    	String[] str=productDescription.split(" ");
    	if(str.length>10)
    	{
    		String res="";
    		for(int i=0;i<10;i++)
    		{
    			res=res+str[i]+" ";
    		}
    		
    		return res+"...";
    	}
    	
    	else
    	{
    		return productDescription+"...";
    	}
    }
    
    public static int getProductSellingPrice(int productPrice,int productDiscountPercent)
    {
    	Double price=Double.parseDouble(String.valueOf(productPrice));
    	Double discount=Double.parseDouble(String.valueOf(productDiscountPercent));
    	Double tenPercentValue=discount*0.01;
    	Double tenPercentOfPrice=tenPercentValue*price;
    	Double finalPrice=productPrice-tenPercentOfPrice;
    	
    	int value = (int)Math.round(finalPrice);
    	
    	return value;
    }

    public static String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        return currentDate.format(formatter);
    }

    public static String getDeliveryDate() {
        LocalDate currentDate = LocalDate.now();
        LocalDate deliveryDate = currentDate.plusDays(10); // Adding 10 days to the current date
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        return deliveryDate.format(formatter);
    }
}
