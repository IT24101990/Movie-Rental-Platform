package com.example.oopcrud.controllers;

import com.example.oopcrud.models.RentModel;
import com.example.oopcrud.services.RentalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/rentals")
public class RentalController {

    private final RentalService rentalService;

    @Autowired
    public RentalController(RentalService rentalService) {
        this.rentalService = rentalService;
    }

    // Create a new rental
    @PostMapping
    public ResponseEntity<RentModel> createRental(@RequestBody RentModel rental) {
        rentalService.create(rental);
        return new ResponseEntity<>(rental, HttpStatus.CREATED);
    }

    // Get all rentals
    @GetMapping
    public ResponseEntity<List<RentModel>> getAllRentals() {
        List<RentModel> rentals = rentalService.getAllRentals();
        return new ResponseEntity<>(rentals, HttpStatus.OK);
    }

    // Get rental by ID
    @GetMapping("/{id}")
    public ResponseEntity<RentModel> getRentalById(@PathVariable("id") int id) {
        RentModel rental = rentalService.getById(id);
        if (rental != null) {
            return new ResponseEntity<>(rental, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Update rental
    @PutMapping("/{id}")
    public ResponseEntity<RentModel> updateRental(@PathVariable("id") int id, @RequestBody RentModel rental) {
        rental.setId(id);
        boolean updated = rentalService.update(rental);

        if (updated) {
            return new ResponseEntity<>(rental, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete rental
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRental(@PathVariable("id") int id) {
        boolean deleted = rentalService.delete(id);

        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}