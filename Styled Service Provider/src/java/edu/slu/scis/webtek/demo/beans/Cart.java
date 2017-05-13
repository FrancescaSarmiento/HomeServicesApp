package edu.slu.scis.webtek.demo.beans;

import java.math.BigDecimal;
import java.util.ArrayList;

public class Cart {
    private ArrayList<Product> products = null;
    private BigDecimal totalAmount = BigDecimal.ZERO;
    
    public Cart() {
        products = new ArrayList<>();
    }
    
    public ArrayList<Product> getProducts() {
        return products;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
            
    public void addProduct(Product product) {
        totalAmount = totalAmount.add(product.getPrice());
        products.add(product);
    }
    
    public void removeProduct(int index) {
        Product product = products.remove(index);
        totalAmount = totalAmount.subtract(product.getPrice());
    }
}
