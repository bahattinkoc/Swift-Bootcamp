//
//  Global.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 16.02.2022.
//

import Foundation

// Singleton Design Pattern
class Global{
    static let instance = Global()
    
    private init() {
        
    }
    
    var buses: [Bus] = [Bus(id: 1, from: "İSTANBUL", to: "SİVAS", date: Date(day: 18, mounth: 02, year: 2022), time: Time(hour: 5, minute: 0), fee: 200),
                        Bus(id: 2, from: "İSTANBUL", to: "GÜMÜŞHANE", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 7, minute: 0), fee: 80),
                        Bus(id: 3, from: "İSTANBUL", to: "VAN", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 11, minute: 30), fee: 240),
                        Bus(id: 4, from: "İSTANBUL", to: "BURSA", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 180),
                        Bus(id: 5, from: "İSTANBUL", to: "BURDUR", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 40),
                        Bus(id: 6, from: "İSTANBUL", to: "ESKİŞEHİR", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 70),
                        Bus(id: 7, from: "İSTANBUL", to: "ÇANKIRI", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 900),
                        Bus(id: 8, from: "İSTANBUL", to: "OSMANİYE", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 110),
                        Bus(id: 9, from: "İSTANBUL", to: "KOCAELİ", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 60),
                        Bus(id: 10, from: "İSTANBUL", to: "GAZİANTEP", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 10),
                        Bus(id: 11, from: "İSTANBUL", to: "HATAY", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 90),
                        Bus(id: 12, from: "İSTANBUL", to: "KAYSERİ", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 45),
                        Bus(id: 13, from: "İSTANBUL", to: "SAKARYA", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 85),
                        Bus(id: 14, from: "İSTANBUL", to: "BAYBURT", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 300),
                        Bus(id: 15, from: "İSTANBUL", to: "ÇANAKKALE", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 200),
                        Bus(id: 16, from: "İSTANBUL", to: "SİNOP", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 22, minute: 30), fee: 150),
                        Bus(id: 17, from: "İSTANBUL", to: "SİVAS", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 21, minute: 00), fee: 330),
                        Bus(id: 18, from: "İSTANBUL", to: "SİVAS", date: Date(day: 18, mounth: 2, year: 2022), time: Time(hour: 23, minute: 30), fee: 200)]
    var selectedBus: Bus?
    var selectedTicket: Ticket?
}
