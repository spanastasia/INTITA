//
//  OpportunitiesType.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.01.2021.
//

import Foundation

enum OpportunitiesType: Int, Codable, CaseIterable {
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
    
    var items: [String] {
        switch self {
        case .course:
            return [
                "finances".localized,
                "available_courses_modules".localized,
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
    
}
