//
//  QuizViewModel.swift
//  App
//
//  Created by mridul-ziroh on 21/03/25.
//
import Foundation
import Combine

class QuizViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = []
    var networkService = QuizNetworkApi()
    @Published var quizs : [Quiz] = []
    
    func fetchQuizes(){
        networkService.fetchQuizzes()
            .sink { [weak self] quizes in
                print(quizes.count)
                self?.quizs = quizes
            }
            .store(in: &cancellables)
    }
    
    func answer(_ id: Int, _ option: String ){
        guard let idx = quizs.firstIndex(where: {$0.id == id}) else { return }
        DispatchQueue.main.async{
            self.quizs[idx] = Quiz(
                id: self.quizs[idx].id,
                question: self.quizs[idx].question,
                options: self.quizs[idx].options,
                answer: self.quizs[idx].answer,
                selectedOption: option // ✅ Update selected option correctly
            )
        }
    }
}
