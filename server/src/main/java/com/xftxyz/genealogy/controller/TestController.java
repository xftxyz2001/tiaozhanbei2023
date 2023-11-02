package com.xftxyz.genealogy.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("/test")
public class TestController {
    @RequestMapping("/test1")
    public String test1() {
        return new Date().toString();
    }
}
