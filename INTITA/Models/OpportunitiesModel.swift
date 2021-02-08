//
//  OpportunitiesModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.01.2021.
//

import Foundation

enum OpportunitiesModel: Int, Codable, CaseIterable {
    case course
    case task
    case study
    
    var sectionTitle: String {
        switch self {
 
        case .course:
            return "courses_modules_finance".localized
        case .task:
            return "tasks_detailed_answer".localized
        case .study:
            return "type_training".localized
        }
    }
    
    var sectionInfo: String {
        switch self {
 
        case .course:
            return "information_about_course".localized
        case .task:
            return "answer_assessments".localized
        case .study:
            return "courses_modules_etc".localized
        }
    }
    
    var sectionButonTask: String {
        switch self {
 
        case .course:
            return "finances".localized
        case .task:
            return "tasks_detailed_answer".localized
        case .study:
            return "type_training".localized
        }
    }
    
    var sectionButonFinance: String {
        switch self {
        case .course:
            return "available_courses_modules".localized
        default: return ""
        }
    }
    
    var items: [String] {
        switch self {
        case .course:
            return [
                "finances".localized,
                "available_courses_modules".localized
            ]
        case .task:
            return [
                "tasks_detailed_answer".localized
            ]
        case .study:
            return [
                "type_training".localized
            ]
        }
    }
//    
//    var itemsCount: Int {
//        switch self {
//
//        case .course:
//            return 2
//        case .task:
//            return 1
//        case .study:
//            return 1
//        }
//    }
}
