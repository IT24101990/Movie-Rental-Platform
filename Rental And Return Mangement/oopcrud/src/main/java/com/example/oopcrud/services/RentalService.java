package com.example.oopcrud.services;

import com.example.oopcrud.models.RentModel;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


@Service
public class RentalService {
    private static final String FILE_PATH = "rentals.txt";
    
    public RentalService() {
        createFileIfNotExists();
    }

    //create the text file
    private void createFileIfNotExists() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Create operation
    public void create(RentModel rental) {
        List<RentModel> rentals = getAllRentals();
        rental.setId(generateId(rentals));
        rentals.add(rental);
        saveToFile(rentals);
    }
    
    // Read operation - Get by ID
    public RentModel getById(int id) {
        List<RentModel> rentals = getAllRentals();
        return rentals.stream()
                     .filter(rental -> rental.getId() == id)
                     .findFirst()
                     .orElse(null);
    }
    
    // Read operation - Get all
    public List<RentModel> getAllRentals() {
        List<RentModel> rentals = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                RentModel rental = parseRental(line);
                if (rental != null) {
                    rentals.add(rental);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rentals;
    }
    
    // Update operation
    public boolean update(RentModel updatedRental) {
        List<RentModel> rentals = getAllRentals();
        boolean found = false;
        
        for (int i = 0; i < rentals.size(); i++) {
            if (rentals.get(i).getId() == updatedRental.getId()) {
                rentals.set(i, updatedRental);
                found = true;
                break;
            }
        }
        
        if (found) {
            saveToFile(rentals);
        }
        return found;
    }
    
    // Delete operation
    public boolean delete(int id) {
        List<RentModel> rentals = getAllRentals();
        boolean removed = rentals.removeIf(rental -> rental.getId() == id);
        
        if (removed) {
            saveToFile(rentals);
        }
        return removed;
    }
    
    private int generateId(List<RentModel> rentals) {
        return rentals.isEmpty() ? 1 : rentals.get(rentals.size() - 1).getId() + 1;
    }
    
    private void saveToFile(List<RentModel> rentals) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (RentModel rental : rentals) {
                writer.write(convertRentalToString(rental));
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    private String convertRentalToString(RentModel rental) {
        return String.format("%d|%s|%s|%s|%s|%.2f|%.2f|%s|%s|%s",
            rental.getId(),
            rental.getMovieName(),
            rental.getCustomerName(),
            rental.getRentedDate(),
            rental.getRentedTime(),
            rental.getPrice(),
            rental.getFine(),
            rental.getStatus(),
            rental.getContactNumber(),
            rental.getCreatedAt().toString()
        );
    }
    
    private RentModel parseRental(String line) {
        try {
            String[] parts = line.split("\\|");
            RentModel rental = new RentModel();
            rental.setId(Integer.parseInt(parts[0]));
            rental.setMovieName(parts[1]);
            rental.setCustomerName(parts[2]);
            rental.setRentedDate(parts[3]);
            rental.setRentedTime(parts[4]);
            rental.setPrice(Double.parseDouble(parts[5]));
            rental.setFine(Double.parseDouble(parts[6]));
            rental.setStatus(parts[7]);
            rental.setContactNumber(parts[8]);
            return rental;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
