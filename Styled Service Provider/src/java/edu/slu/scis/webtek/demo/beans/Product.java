package edu.slu.scis.webtek.demo.beans;

import java.math.BigDecimal;

public class Product {
    private String prodId, category, description;
    private BigDecimal price;

    public Product(String prodId, String category, String description, BigDecimal price) {
        this.prodId = prodId;
        this.category = category;
        this.description = description;
        this.price = price;
    }
    
    public String getProdId() {
        return prodId;
    }

    public String getCategory() {
        return category;
    }
    
    public String getDescription() {
        return description;
    }

    public BigDecimal getPrice() {
        return price;
    }
}
