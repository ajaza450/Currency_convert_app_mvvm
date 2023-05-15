//
//  CurrencyConverterModel.swift
//  CurrnecyConvertTest
//
//  Created by EZAZ AHAMD on 04/03/23.
//

import Foundation

class CurrencyConverterViewModel{
    private let userDefaults = UserDefaults.standard
    private let updateInterval: TimeInterval = 30 * 60 // 30 minutes
    private var lastUpdated: Date?
    var currencies = [Currency]()
    var conversions = [Conversion]()
    
    var eventHandler: ((_ event: Event)->Void)?
    
    
    //MARK: - Fatch Data From APi
    
    func fetchCurrencies(){
         NetworkService.shared.request(type: ExchangerateEndPoint.get_latest_rate, modelType: Json_Base.self) {[weak self] response  in
            switch response {
            case .success(let model):
                self?.lastUpdated = Date()
                self?.currencies_array(model)
                break
            case .failure(let error):
                self?.eventHandler?(.error_fatchCurrencies(error.localizedDescription))
                break
                
            }
        }
    }
    
    //MARK: - Handel Data trasformations
    fileprivate func currencies_array(_ model: Json_Base) {
        let mirror = Mirror(reflecting: model.rates)
        for child in mirror.children {
            let valueMirror = Mirror(reflecting: child.value)
            for child_value in valueMirror.children {
                if let propertyName = child_value.label?.uppercased(), let rate =   child_value.value as? Double{
                    print("Key name: \(propertyName) and rate is \(rate)")
                    currencies.append(Currency(rate:rate, name: propertyName))
                }
            }
        }
        save()
    }
    
    //MARK: - Check Time
    
    func isExchangeRateStale() -> Bool {
        return lastUpdated == nil || Date().timeIntervalSince(lastUpdated!) > updateInterval
    }
    
    //MARK: - Conversion mechanisum
    
    func convert(amount: Double, fromCurrency: Currency, toCurrencies: [Currency]){
        conversions = []
      for currency in toCurrencies {
          let baseRate = fromCurrency.rate ?? 1.0
          let targetRate = currency.rate ?? 1.0
          let convertedAmount = (amount / baseRate) * targetRate
          print("\(currency.name): \(convertedAmount)")
          conversions.append(Conversion(currency: currency, amount: convertedAmount))
      }
        eventHandler?(.currencies_converted)
    }
    
    //MARK: - Save Data In UserDefault
    
    func save() {
        let encoder = JSONEncoder()
        if let currenciesData = try? encoder.encode(currencies) {
            userDefaults.set(currenciesData, forKey: "currencies")
        }
       
        if let lastUpdated = lastUpdated {
            userDefaults.set(lastUpdated, forKey: "lastUpdated")
        }
    }
   
    //MARK: - Retrive Data From UserDefault
    
    func load_saved_data() {
        let decoder = JSONDecoder()
        if let currenciesData = userDefaults.data(forKey: "currencies"),
            let currencies = try? decoder.decode([Currency].self, from: currenciesData) {
            self.currencies = currencies
        }
        
        if let lastUpdated = userDefaults.object(forKey: "lastUpdated") as? Date {
            self.lastUpdated = lastUpdated
        }
        
        DispatchQueue.main.async {
            if self.isExchangeRateStale() {
                self.fetchCurrencies()
            }
        }
        
    }
    
    
}



extension CurrencyConverterViewModel {
    
    enum Event {
        case currencies_converted
        case error_fatchCurrencies(_ message: String)
        case error(_ message: String)
        
    }
}

