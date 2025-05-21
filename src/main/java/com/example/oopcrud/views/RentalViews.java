package com.example.oopcrud.views;

import com.example.oopcrud.models.RentModel;
import com.example.oopcrud.services.RentalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class RentalViews {

    @Autowired
    private  RentalService rentalService;

    @GetMapping
    public  String index(Model model){
        List<RentModel> rents = rentalService.getAllRentals();
        model.addAttribute("rents",rents);
        return "index";
    }

    @GetMapping("/create")
    public  String create(){

        return "create";
    }

    @GetMapping("/edit/{id}")
    public  String edit(@PathVariable String id, Model model){
       RentModel rent =   rentalService.getById(Integer.parseInt(id));
       model.addAttribute("rend",rent);
        return "edit";
    }
}
