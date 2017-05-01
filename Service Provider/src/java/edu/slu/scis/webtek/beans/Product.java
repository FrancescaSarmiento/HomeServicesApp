package edu.slu.scis.webtek.beans;

import java.math.BigDecimal;

public class Product {
    private String id;
    private String desc;
    private BigDecimal price;

    public Product(String id, String desc, BigDecimal price) {
        setId(id);
        setDesc(desc);
        setPrice(price);
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
