//
//  User.swift
//  AppStore
//
//  Created by Wenqi Wang on 09/04/2017.
//  Copyright © 2017 Wenqi Wang. All rights reserved.
//

import UIKit

class User: NSObject {
    var numPeople: Int?
    var numMeals: Int?
    var dietaryRestrictions: [String]?
    var uid: String?
    
    init(numPeople: Int, numMeals: Int, dietaryRestrictions: [String], uid: String){
        self.numPeople = numPeople
        self.numMeals = numMeals
        self.dietaryRestrictions = dietaryRestrictions
        self.uid = uid
    }
    
    // pick recipes that meet user's dietary restrictions
    func pickRecipes(user: User) -> [Recipe] {
        var pickedRecipes = [Recipe]()
        var idx = 0
        var restrictedRecipes = [Recipe]()
        
        if user.dietaryRestrictions! != [] {
            for recipe in recipeArray {
                for dietRes in user.dietaryRestrictions! {
                    if recipe.tag.contains(dietRes.lowercased()) {
                        restrictedRecipes.append(recipe)
                    }
                    break
                }
            }
        }
        else {
            restrictedRecipes = recipeArray
        }
        
        //  select recipes based on number of people
        repeat {
            let recipe = restrictedRecipes.randomElement()
            pickedRecipes.append(recipe!)
            idx = idx + 1
        } while(idx < user.numMeals!)
        return pickedRecipes
    }
    
    // pick recipes that meet user's dietary restrictions and that are Asian
    func pickAsianRecipes(user: User) -> [Recipe] {
        var pickedRecipes = [Recipe]()
        var idx = 0
        var restrictedRecipes = [Recipe]()
        if user.dietaryRestrictions! != []{
            for recipe in recipeArray {
                for dietRes in user.dietaryRestrictions! {
                    if recipe.tag.contains(dietRes.lowercased()) && recipe.category == "asian fusion" {
                        restrictedRecipes.append(recipe)
                    }
                    break
                }
            }
        }
            
        else {
            for recipe in recipeArray {
                if recipe.category == "asian fusion" {
                    restrictedRecipes.append(recipe)
                }
            }
        }
        
        repeat {
            let recipe = restrictedRecipes.randomElement()
            pickedRecipes.append(recipe!)
            idx = idx + 1
        } while(idx < user.numMeals!)
        return pickedRecipes
    }
    
    // pick recipes that meet user's dietary restrictions and that are American
    func pickAmericanRecipes(user: User) -> [Recipe] {
        var pickedRecipes = [Recipe]()
        var idx = 0
        var restrictedRecipes = [Recipe]()
        if user.dietaryRestrictions! != []{
            for recipe in recipeArray {
                for dietRes in user.dietaryRestrictions! {
                    if recipe.tag.contains(dietRes.lowercased()) && recipe.category == "traditional" {
                        restrictedRecipes.append(recipe)
                    }
                    break
                }
            }
        }
            
        else {
            for recipe in recipeArray {
                if recipe.category == "traditional" {
                    restrictedRecipes.append(recipe)
                }
            }
        }
        
        repeat {
            let recipe = restrictedRecipes.randomElement()
            pickedRecipes.append(recipe!)
            idx = idx + 1
        } while(idx < user.numMeals!)
        return pickedRecipes
    }
    
    // pick recipes that meet user's dietary restrictions and that are European
    func pickEuropeanRecipes(user: User) -> [Recipe] {
        var pickedRecipes = [Recipe]()
        var idx = 0
        var restrictedRecipes = [Recipe]()
        if user.dietaryRestrictions! != []{
            for recipe in recipeArray {
                for dietRes in user.dietaryRestrictions! {
                    if recipe.tag.contains(dietRes.lowercased()) && recipe.category == "european" {
                        restrictedRecipes.append(recipe)
                    }
                    break
                }
            }
        }
            
        else {
            for recipe in recipeArray {
                if recipe.category == "european" {
                    restrictedRecipes.append(recipe)
                }
            }
        }
        
        repeat {
            let recipe = restrictedRecipes.randomElement()
            pickedRecipes.append(recipe!)
            idx = idx + 1
        } while(idx < user.numMeals!)
        return pickedRecipes
    }
}
