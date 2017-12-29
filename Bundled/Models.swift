//
//  Models.swift
//  AppStore
//
//  Created by Wenqi Wang on 25/03/2017.
//  Copyright © 2017 Wenqi Wang. All rights reserved.
//

import UIKit

class FeaturedBundles: NSObject {
    
    var bannerCategory: BundleCategory?
    var bundleCategories: [BundleCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            bundleCategories = [BundleCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let bundleCategory = BundleCategory()
                bundleCategory.setValuesForKeys(dict)
                bundleCategories?.append(bundleCategory)
            }
            
        } else if key == "bannerCategory" {
            bannerCategory = BundleCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}

// difine bundle categories for FeaturedBundlesController
class BundleCategory: NSObject{
    var name: String?
    var bundles: [Bundles]?//to change to bundles
    var type: String?
    
    static func sampleBundleCategories() -> [FeaturedBundles] {
        
        let featuredBundles = FeaturedBundles()
        let bannerBundlesCatgory = BundleCategory()
        var featuredBundlesCategory = [BundleCategory]()
        
        var bannerBundles = [Bundles]()
        
        // get all available recipes
        
        recipeArray.append(frenchToastRecipe)
        recipeArray.append(scrambledEggsRecipe)
        recipeArray.append(flatPizzaRecipe)
        recipeArray.append(asianBeefRecipe)
        recipeArray.append(balsamicGlazedCarrots)
        recipeArray.append(greenBeanandPotatoSalad)
        recipeArray.append(mangoSalsaonTilapiaFillets)
        recipeArray.append(sesameGreenBeans)
        recipeArray.append(cedarPlankedSalmon)
        recipeArray.append(broccoli)
        recipeArray.append(kungpao)
        recipeArray.append(spareribs)
        recipeArray.append(buns)
        recipeArray.append(chickenThigh)
        recipeArray.append(chineseRib)
        recipeArray.append(cabbageFat)
        recipeArray.append(VegeBibimbap)
        recipeArray.append(puffwaffles)
        recipeArray.append(potatosalad)
        recipeArray.append(sandwich)
        recipeArray.append(couscousSalad)
        recipeArray.append(chickenblue)
        recipeArray.append(greekpasta)
        recipeArray.append(italianSoup)
        recipeArray.append(frenchCrep)
        recipeArray.append(burrito)
        recipeArray.append(tofu)
        recipeArray.append(burger)
        
        // set featured bundles in the header of featured bundle page
        
        let firstFeaturedBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        firstFeaturedBundle.name = "Energy Boost: Morning to Night"
        firstFeaturedBundle.imageName = "bundle3"
        firstFeaturedBundle.category = "Traditional American"
        firstFeaturedBundle.recipes = myUser.pickRecipes(user: myUser)
        firstFeaturedBundle.price = firstFeaturedBundle.sumPrice(recipes: firstFeaturedBundle.recipes)
        firstFeaturedBundle.prepTime = firstFeaturedBundle.sumPrepTime(recipes: firstFeaturedBundle.recipes)
        firstFeaturedBundle.cookTime = firstFeaturedBundle.sumCookTime(recipes: firstFeaturedBundle.recipes)
        firstFeaturedBundle.totalTime = firstFeaturedBundle.prepTime + firstFeaturedBundle.cookTime
        firstFeaturedBundle.preperations = firstFeaturedBundle.allPreperations(bundle: firstFeaturedBundle)
        firstFeaturedBundle.ingredients = firstFeaturedBundle.allIngredients(bundle: firstFeaturedBundle)

        bannerBundles.append(firstFeaturedBundle)
        
        let secondFeaturedBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        secondFeaturedBundle.name = "Everybody Wants Some Refresh"
        secondFeaturedBundle.imageName = "bundle4"
        secondFeaturedBundle.category = "Asian"
        secondFeaturedBundle.recipes = myUser.pickRecipes(user: myUser)
        secondFeaturedBundle.price = secondFeaturedBundle.sumPrice(recipes: secondFeaturedBundle.recipes)
        secondFeaturedBundle.prepTime = secondFeaturedBundle.sumPrepTime(recipes: secondFeaturedBundle.recipes)
        secondFeaturedBundle.cookTime = secondFeaturedBundle.sumCookTime(recipes: secondFeaturedBundle.recipes)
        secondFeaturedBundle.totalTime = secondFeaturedBundle.prepTime + secondFeaturedBundle.cookTime
        secondFeaturedBundle.preperations = secondFeaturedBundle.allPreperations(bundle: secondFeaturedBundle)
        secondFeaturedBundle.ingredients = secondFeaturedBundle.allIngredients(bundle: secondFeaturedBundle)

        bannerBundles.append(secondFeaturedBundle)
        
        let thirdFeaturedBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        thirdFeaturedBundle.name = "One Week Body Transformation"
        thirdFeaturedBundle.imageName = "bundle5"
        thirdFeaturedBundle.category = "Mexican"
        thirdFeaturedBundle.recipes = myUser.pickRecipes(user: myUser)
        thirdFeaturedBundle.price = thirdFeaturedBundle.sumPrice(recipes: thirdFeaturedBundle.recipes)
        thirdFeaturedBundle.prepTime = thirdFeaturedBundle.sumPrepTime(recipes: thirdFeaturedBundle.recipes)
        thirdFeaturedBundle.cookTime = thirdFeaturedBundle.sumCookTime(recipes: thirdFeaturedBundle.recipes)
        thirdFeaturedBundle.totalTime = thirdFeaturedBundle.prepTime + thirdFeaturedBundle.cookTime
        thirdFeaturedBundle.preperations = thirdFeaturedBundle.allPreperations(bundle: thirdFeaturedBundle)
        thirdFeaturedBundle.ingredients = thirdFeaturedBundle.allIngredients(bundle: thirdFeaturedBundle)

        bannerBundles.append(thirdFeaturedBundle)
        
        bannerBundlesCatgory.bundles = bannerBundles
        
        // set bundles in each bundle category, their recipes, preparations, ingredients are generated upon user's input
        
        // set bundles in the global foods category
        
        let globalBundlesCategory = BundleCategory()
        globalBundlesCategory.name = "Global foods"
        
        var bundles = [Bundles]()
        
        // logic
        let oneoneBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        oneoneBundle.name = "Simple Made Delicious"
        oneoneBundle.imageName = "globalbundle1"
        oneoneBundle.category = "Global"
        oneoneBundle.recipes = myUser.pickRecipes(user: myUser)
        oneoneBundle.price = oneoneBundle.sumPrice(recipes: oneoneBundle.recipes)
        oneoneBundle.prepTime = oneoneBundle.sumPrepTime(recipes: oneoneBundle.recipes)
        oneoneBundle.cookTime = oneoneBundle.sumCookTime(recipes: oneoneBundle.recipes)
        oneoneBundle.totalTime = oneoneBundle.prepTime + oneoneBundle.cookTime
        oneoneBundle.preperations = oneoneBundle.allPreperations(bundle: oneoneBundle)
        oneoneBundle.ingredients = oneoneBundle.allIngredients(bundle: oneoneBundle)
        bundles.append(oneoneBundle)

        let onetwoBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        onetwoBundle.name = "World on Your Tongue"
        onetwoBundle.imageName = "globalbundle2"
        onetwoBundle.category = "Global"
        onetwoBundle.recipes = myUser.pickRecipes(user: myUser)
        onetwoBundle.price = onetwoBundle.sumPrice(recipes: onetwoBundle.recipes)
        onetwoBundle.prepTime = onetwoBundle.sumPrepTime(recipes: onetwoBundle.recipes)
        onetwoBundle.cookTime = onetwoBundle.sumCookTime(recipes: onetwoBundle.recipes)
        onetwoBundle.totalTime = onetwoBundle.prepTime + onetwoBundle.cookTime
        onetwoBundle.preperations = onetwoBundle.allPreperations(bundle: onetwoBundle)
        onetwoBundle.ingredients = onetwoBundle.allIngredients(bundle: onetwoBundle)
        bundles.append(onetwoBundle)
        
        let onethreeBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        onethreeBundle.name = "Going International"
        onethreeBundle.imageName = "globalbundle3"
        onethreeBundle.category = "Global"
        onethreeBundle.recipes = myUser.pickRecipes(user: myUser)
        onethreeBundle.price = onethreeBundle.sumPrice(recipes: onethreeBundle.recipes)
        onethreeBundle.prepTime = onethreeBundle.sumPrepTime(recipes: onethreeBundle.recipes)
        onethreeBundle.cookTime = onethreeBundle.sumCookTime(recipes: onethreeBundle.recipes)
        onethreeBundle.totalTime = onethreeBundle.prepTime + onethreeBundle.cookTime
        onethreeBundle.preperations = onethreeBundle.allPreperations(bundle: onethreeBundle)
        onethreeBundle.ingredients = onethreeBundle.allIngredients(bundle: onethreeBundle)
        bundles.append(onethreeBundle)
        
        let onefourBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        onefourBundle.name = "Tasty is Easy"
        onefourBundle.imageName = "globalbundle4"
        onefourBundle.category = "Global"
        onefourBundle.recipes = myUser.pickRecipes(user: myUser)
        onefourBundle.price = onefourBundle.sumPrice(recipes: onefourBundle.recipes)
        onefourBundle.prepTime = onefourBundle.sumPrepTime(recipes: onefourBundle.recipes)
        onefourBundle.cookTime = onefourBundle.sumCookTime(recipes: onefourBundle.recipes)
        onefourBundle.totalTime = onefourBundle.prepTime + onefourBundle.cookTime
        onefourBundle.preperations = onefourBundle.allPreperations(bundle: onefourBundle)
        onefourBundle.ingredients = onefourBundle.allIngredients(bundle: onefourBundle)
        bundles.append(onefourBundle)
        
        let onefiveBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        onefiveBundle.name = "Words cannot Explain"
        onefiveBundle.imageName = "globalbundle5"
        onefiveBundle.category = "Global"
        onefiveBundle.recipes = myUser.pickRecipes(user: myUser)
        onefiveBundle.price = onefiveBundle.sumPrice(recipes: onefiveBundle.recipes)
        onefiveBundle.prepTime = onefiveBundle.sumPrepTime(recipes: onefiveBundle.recipes)
        onefiveBundle.cookTime = onefiveBundle.sumCookTime(recipes: onefiveBundle.recipes)
        onefiveBundle.totalTime = onefiveBundle.prepTime + onefiveBundle.cookTime
        onefiveBundle.preperations = onefiveBundle.allPreperations(bundle: onefiveBundle)
        onefiveBundle.ingredients = onefiveBundle.allIngredients(bundle: onefiveBundle)
        bundles.append(onefiveBundle)

        globalBundlesCategory.bundles = bundles
        
        featuredBundlesCategory.append(globalBundlesCategory)
        
        // set bundles in the asian foods category
        
        let asianBundlesCategory = BundleCategory()
        asianBundlesCategory.name = "Asian Tastes"
        
        var asianBundles = [Bundles]()
        
        let twoooneBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        twoooneBundle.name = "Asian Taste"
        twoooneBundle.imageName = "asianbundle1"
        twoooneBundle.category = "Asian Fusion"
        twoooneBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        twoooneBundle.price = twoooneBundle.sumPrice(recipes: twoooneBundle.recipes)
        twoooneBundle.prepTime = twoooneBundle.sumPrepTime(recipes: twoooneBundle.recipes)
        twoooneBundle.cookTime = twoooneBundle.sumCookTime(recipes: twoooneBundle.recipes)
        twoooneBundle.totalTime = twoooneBundle.prepTime + twoooneBundle.cookTime
        twoooneBundle.preperations = twoooneBundle.allPreperations(bundle: twoooneBundle)
        twoooneBundle.ingredients = twoooneBundle.allIngredients(bundle: twoooneBundle)

        asianBundles.append(twoooneBundle)
        
        let twootwoBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        twootwoBundle.name = "Nihao (Hello)"
        twootwoBundle.imageName = "asianbundle2"
        twootwoBundle.category = "Asian Fusion"
        twootwoBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        twootwoBundle.price = twootwoBundle.sumPrice(recipes: twootwoBundle.recipes)
        twootwoBundle.prepTime = twootwoBundle.sumPrepTime(recipes: twootwoBundle.recipes)
        twootwoBundle.cookTime = twootwoBundle.sumCookTime(recipes: twootwoBundle.recipes)
        twootwoBundle.totalTime = twootwoBundle.prepTime + twootwoBundle.cookTime
        twootwoBundle.preperations = twootwoBundle.allPreperations(bundle: twootwoBundle)
        twootwoBundle.ingredients = twootwoBundle.allIngredients(bundle: twootwoBundle)
        asianBundles.append(twootwoBundle)
        
        let twoothreeBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        twoothreeBundle.name = "Fortune in a Cookie"
        twoothreeBundle.imageName = "asianbundle3"
        twoothreeBundle.category = "Asian Fusion"
        twoothreeBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        twoothreeBundle.price = twoothreeBundle.sumPrice(recipes: twoothreeBundle.recipes)
        twoothreeBundle.prepTime = twoothreeBundle.sumPrepTime(recipes: twoothreeBundle.recipes)
        twoothreeBundle.cookTime = twoothreeBundle.sumCookTime(recipes: twoothreeBundle.recipes)
        twoothreeBundle.totalTime = twoothreeBundle.prepTime + twoothreeBundle.cookTime
        twoothreeBundle.preperations = twoothreeBundle.allPreperations(bundle: twoothreeBundle)
        twoothreeBundle.ingredients = twoothreeBundle.allIngredients(bundle: twoothreeBundle)
        asianBundles.append(twoothreeBundle)
        
        let twofourBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        twofourBundle.name = "Red Lantern"
        twofourBundle.imageName = "asianbundle4"
        twofourBundle.category = "Asian Fusion"
        twofourBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        twofourBundle.price = twofourBundle.sumPrice(recipes: twofourBundle.recipes)
        twofourBundle.prepTime = twofourBundle.sumPrepTime(recipes: twofourBundle.recipes)
        twofourBundle.cookTime = twofourBundle.sumCookTime(recipes: twofourBundle.recipes)
        twofourBundle.totalTime = twofourBundle.prepTime + twofourBundle.cookTime
        twofourBundle.preperations = twofourBundle.allPreperations(bundle: twofourBundle)
        twofourBundle.ingredients = twofourBundle.allIngredients(bundle: twofourBundle)
        asianBundles.append(twofourBundle)
        
        let twofiveBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        twofiveBundle.name = "Chinese Street Foods"
        twofiveBundle.imageName = "asianbundle5"
        twofiveBundle.category = "Asian Fusion"
        twofiveBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        twofiveBundle.price = twofiveBundle.sumPrice(recipes: twofiveBundle.recipes)
        twofiveBundle.prepTime = twofiveBundle.sumPrepTime(recipes: twofiveBundle.recipes)
        twofiveBundle.cookTime = twofiveBundle.sumCookTime(recipes: twofiveBundle.recipes)
        twofiveBundle.totalTime = twofiveBundle.prepTime + twofiveBundle.cookTime
        twofiveBundle.preperations = twofiveBundle.allPreperations(bundle: twofiveBundle)
        twofiveBundle.ingredients = twofiveBundle.allIngredients(bundle: twofiveBundle)
        asianBundles.append(twofiveBundle)
        
        
        asianBundlesCategory.bundles = asianBundles
        
        featuredBundlesCategory.append(asianBundlesCategory)
        
        // set bundles in the European foods category
        
        let euroBundlesCategory = BundleCategory()
        euroBundlesCategory.name = "European Style"
        
        var euroBundles = [Bundles]()
        
        let threeoneBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        threeoneBundle.name = "Bonjour!"
        threeoneBundle.imageName = "eurobundle1"
        threeoneBundle.category = "European"
        threeoneBundle.recipes = myUser.pickEuropeanRecipes(user: myUser)
        threeoneBundle.price = threeoneBundle.sumPrice(recipes: threeoneBundle.recipes)
        threeoneBundle.prepTime = threeoneBundle.sumPrepTime(recipes: threeoneBundle.recipes)
        threeoneBundle.cookTime = threeoneBundle.sumCookTime(recipes: threeoneBundle.recipes)
        threeoneBundle.totalTime = threeoneBundle.prepTime + threeoneBundle.cookTime
        threeoneBundle.preperations = threeoneBundle.allPreperations(bundle: threeoneBundle)
        threeoneBundle.ingredients = threeoneBundle.allIngredients(bundle: threeoneBundle)
        euroBundles.append(threeoneBundle)
        
        let threetwoBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        threetwoBundle.name = "Hola!"
        threetwoBundle.imageName = "eurobundle2"
        threetwoBundle.category = "European"
        threetwoBundle.recipes = myUser.pickEuropeanRecipes(user: myUser)
        threetwoBundle.price = threetwoBundle.sumPrice(recipes: threetwoBundle.recipes)
        threetwoBundle.prepTime = threetwoBundle.sumPrepTime(recipes: threetwoBundle.recipes)
        threetwoBundle.cookTime = threetwoBundle.sumCookTime(recipes: threetwoBundle.recipes)
        threetwoBundle.totalTime = threetwoBundle.prepTime + threetwoBundle.cookTime
        threetwoBundle.preperations = threetwoBundle.allPreperations(bundle: threetwoBundle)
        threetwoBundle.ingredients = threetwoBundle.allIngredients(bundle: threetwoBundle)
        euroBundles.append(threetwoBundle)
        
        let threethreeBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        threethreeBundle.name = "One Week in Berlin"
        threethreeBundle.imageName = "eurobundle3"
        threethreeBundle.category = "European"
        threethreeBundle.recipes = myUser.pickEuropeanRecipes(user: myUser)
        threethreeBundle.price = threethreeBundle.sumPrice(recipes: threethreeBundle.recipes)
        threethreeBundle.prepTime = threethreeBundle.sumPrepTime(recipes: threethreeBundle.recipes)
        threethreeBundle.cookTime = threethreeBundle.sumCookTime(recipes: threethreeBundle.recipes)
        threethreeBundle.totalTime = threethreeBundle.prepTime + threethreeBundle.cookTime
        threethreeBundle.preperations = threethreeBundle.allPreperations(bundle: threethreeBundle)
        threethreeBundle.ingredients = threethreeBundle.allIngredients(bundle: threethreeBundle)
        euroBundles.append(threethreeBundle)
        
        let threefourBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        threefourBundle.name = "Mount Blanc"
        threefourBundle.imageName = "eurobundle4"
        threefourBundle.category = "European"
        threefourBundle.recipes = myUser.pickEuropeanRecipes(user: myUser)
        threefourBundle.price = threefourBundle.sumPrice(recipes: threefourBundle.recipes)
        threefourBundle.prepTime = threefourBundle.sumPrepTime(recipes: threefourBundle.recipes)
        threefourBundle.cookTime = threefourBundle.sumCookTime(recipes: threefourBundle.recipes)
        threefourBundle.totalTime = threefourBundle.prepTime + threefourBundle.cookTime
        threefourBundle.preperations = threefourBundle.allPreperations(bundle: threefourBundle)
        threefourBundle.ingredients = threefourBundle.allIngredients(bundle: threefourBundle)
        euroBundles.append(threefourBundle)
        
        euroBundlesCategory.bundles = euroBundles
        
        featuredBundlesCategory.append(euroBundlesCategory)
        
        // set bundles in the American foods category

        let americanBundlesCategory = BundleCategory()
        americanBundlesCategory.name = "American Favorates"

        var americanBundles = [Bundles]()
        
        let fouroneBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fouroneBundle.name = "Traditional is Good"
        fouroneBundle.imageName = "americanbundle1"
        fouroneBundle.category = "Traditional"
        fouroneBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fouroneBundle.price = fouroneBundle.sumPrice(recipes: fouroneBundle.recipes)
        fouroneBundle.prepTime = fouroneBundle.sumPrepTime(recipes: fouroneBundle.recipes)
        fouroneBundle.cookTime = fouroneBundle.sumCookTime(recipes: fouroneBundle.recipes)
        fouroneBundle.totalTime = fouroneBundle.prepTime + fouroneBundle.cookTime
        fouroneBundle.preperations = fouroneBundle.allPreperations(bundle: fouroneBundle)
        fouroneBundle.ingredients = fouroneBundle.allIngredients(bundle: fouroneBundle)
        americanBundles.append(fouroneBundle)
        
        let fourtwoBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fourtwoBundle.name = "Make Food Great Again"
        fourtwoBundle.imageName = "americanbundle2"
        fourtwoBundle.category = "Traditional"
        fourtwoBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fourtwoBundle.price = fourtwoBundle.sumPrice(recipes: fourtwoBundle.recipes)
        fourtwoBundle.prepTime = fourtwoBundle.sumPrepTime(recipes: fourtwoBundle.recipes)
        fourtwoBundle.cookTime = fourtwoBundle.sumCookTime(recipes: fourtwoBundle.recipes)
        fourtwoBundle.totalTime = fourtwoBundle.prepTime + fourtwoBundle.cookTime
        fourtwoBundle.preperations = fourtwoBundle.allPreperations(bundle: fourtwoBundle)
        fourtwoBundle.ingredients = fourtwoBundle.allIngredients(bundle: fourtwoBundle)
        americanBundles.append(fourtwoBundle)
        
        let fourthreeBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fourthreeBundle.name = "Chenqi's Favorite"
        fourthreeBundle.imageName = "americanbundle3"
        fourthreeBundle.category = "Traditional"
        fourthreeBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fourthreeBundle.price = fourthreeBundle.sumPrice(recipes: fourthreeBundle.recipes)
        fourthreeBundle.prepTime = fourthreeBundle.sumPrepTime(recipes: fourthreeBundle.recipes)
        fourthreeBundle.cookTime = fourthreeBundle.sumCookTime(recipes: fourthreeBundle.recipes)
        fourthreeBundle.totalTime = fourthreeBundle.prepTime + fourthreeBundle.cookTime
        fourthreeBundle.preperations = fourthreeBundle.allPreperations(bundle: fourthreeBundle)
        fourthreeBundle.ingredients = fourthreeBundle.allIngredients(bundle: fourthreeBundle)
        americanBundles.append(fourthreeBundle)
        
        let fourfourBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fourfourBundle.name = "Yee Hah!"
        fourfourBundle.imageName = "americanbundle4"
        fourfourBundle.category = "Traditional"
        fourfourBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fourfourBundle.price = fourfourBundle.sumPrice(recipes: fourfourBundle.recipes)
        fourfourBundle.prepTime = fourfourBundle.sumPrepTime(recipes: fourfourBundle.recipes)
        fourfourBundle.cookTime = fourfourBundle.sumCookTime(recipes: fourfourBundle.recipes)
        fourfourBundle.totalTime = fourfourBundle.prepTime + fourfourBundle.cookTime
        fourfourBundle.preperations = fourfourBundle.allPreperations(bundle: fourfourBundle)
        fourfourBundle.ingredients = fourfourBundle.allIngredients(bundle: fourfourBundle)
        americanBundles.append(fourfourBundle)
        
        let fourfiveBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fourfiveBundle.name = "This is sooo Cool"
        fourfiveBundle.imageName = "americanbundle5"
        fourfiveBundle.category = "Traditional"
        fourfiveBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fourfiveBundle.price = fourfiveBundle.sumPrice(recipes: fourfiveBundle.recipes)
        fourfiveBundle.prepTime = fourfiveBundle.sumPrepTime(recipes: fourfiveBundle.recipes)
        fourfiveBundle.cookTime = fourfiveBundle.sumCookTime(recipes: fourfiveBundle.recipes)
        fourfiveBundle.totalTime = fourfiveBundle.prepTime + fourfiveBundle.cookTime
        fourfiveBundle.preperations = fourfiveBundle.allPreperations(bundle: fourfiveBundle)
        fourfiveBundle.ingredients = fourfiveBundle.allIngredients(bundle: fourfiveBundle)
        americanBundles.append(fourfiveBundle)
        
        let fourSixBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fourSixBundle.name = "Rocks in the City"
        fourSixBundle.imageName = "americanbundle6"
        fourSixBundle.category = "Traditional"
        fourSixBundle.recipes = myUser.pickAmericanRecipes(user: myUser)
        fourSixBundle.price = fourSixBundle.sumPrice(recipes: fourSixBundle.recipes)
        fourSixBundle.prepTime = fourSixBundle.sumPrepTime(recipes: fourSixBundle.recipes)
        fourSixBundle.cookTime = fourSixBundle.sumCookTime(recipes: fourSixBundle.recipes)
        fourSixBundle.totalTime = fourSixBundle.prepTime + fourSixBundle.cookTime
        fourSixBundle.preperations = fourSixBundle.allPreperations(bundle: fourSixBundle)
        fourSixBundle.ingredients = fourSixBundle.allIngredients(bundle: fourSixBundle)
        americanBundles.append(fourSixBundle)
        
        americanBundlesCategory.bundles = americanBundles
        featuredBundlesCategory.append(americanBundlesCategory)
        
        // set bundles in the recommended by editor category
        
        let recommendBundlesCategory = BundleCategory()
        recommendBundlesCategory.name = "Recommended by Editors"
        
        var recommendBundles = [Bundles]()
        
        let fiveoneBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fiveoneBundle.name = ";) your day"
        fiveoneBundle.imageName = "recommendbundle1"
        fiveoneBundle.category = "Asian"
        fiveoneBundle.recipes = myUser.pickAsianRecipes(user: myUser)
        fiveoneBundle.price = fiveoneBundle.sumPrice(recipes: fiveoneBundle.recipes)
        fiveoneBundle.prepTime = fiveoneBundle.sumPrepTime(recipes: fiveoneBundle.recipes)
        fiveoneBundle.cookTime = fiveoneBundle.sumCookTime(recipes: fiveoneBundle.recipes)
        fiveoneBundle.totalTime = fiveoneBundle.prepTime + fiveoneBundle.cookTime
        fiveoneBundle.preperations = fiveoneBundle.allPreperations(bundle: fiveoneBundle)
        fiveoneBundle.ingredients = fiveoneBundle.allIngredients(bundle: fiveoneBundle)
        recommendBundles.append(fiveoneBundle)
        
        let fivetwoBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fivetwoBundle.name = "A Must for Foodies"
        fivetwoBundle.imageName = "recommendbundle2"
        fivetwoBundle.category = "Global"
        fivetwoBundle.recipes = myUser.pickRecipes(user: myUser)
        fivetwoBundle.price = fivetwoBundle.sumPrice(recipes: fivetwoBundle.recipes)
        fivetwoBundle.prepTime = fivetwoBundle.sumPrepTime(recipes: fivetwoBundle.recipes)
        fivetwoBundle.cookTime = fivetwoBundle.sumCookTime(recipes: fivetwoBundle.recipes)
        fivetwoBundle.totalTime = fivetwoBundle.prepTime + fivetwoBundle.cookTime
        fivetwoBundle.preperations = fivetwoBundle.allPreperations(bundle: fivetwoBundle)
        fivetwoBundle.ingredients = fivetwoBundle.allIngredients(bundle: fivetwoBundle)
        recommendBundles.append(fivetwoBundle)
        
        let fivethreeBundle = Bundles(id: 0, name: "", category: "", imageName: "", price: 0, cookTime: 0, prepTime: 0, totalTime: 0, recipes: recipeArray, preperations: [beatEggs], ingredients: ["": []])
        fivethreeBundle.name = "TGIF - almost!"
        fivethreeBundle.imageName = "recommendbundle3"
        fivethreeBundle.category = "Global"
        fivethreeBundle.recipes = myUser.pickRecipes(user: myUser)
        fivethreeBundle.price = fivethreeBundle.sumPrice(recipes: fivethreeBundle.recipes)
        fivethreeBundle.prepTime = fivethreeBundle.sumPrepTime(recipes: fivethreeBundle.recipes)
        fivethreeBundle.cookTime = fivethreeBundle.sumCookTime(recipes: fivethreeBundle.recipes)
        fivethreeBundle.totalTime = fivethreeBundle.prepTime + fivethreeBundle.cookTime
        fivethreeBundle.preperations = fivethreeBundle.allPreperations(bundle: fivethreeBundle)
        fivethreeBundle.ingredients = fivethreeBundle.allIngredients(bundle: fivethreeBundle)
        recommendBundles.append(fivethreeBundle)
        
        recommendBundlesCategory.bundles = recommendBundles
        featuredBundlesCategory.append(recommendBundlesCategory)
        
        
        featuredBundles.bannerCategory = bannerBundlesCatgory
        
        featuredBundles.bundleCategories = featuredBundlesCategory
        
        
        return [featuredBundles]
        
    }
}

// an extension for Array type to pick a random element
extension Array {
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}
