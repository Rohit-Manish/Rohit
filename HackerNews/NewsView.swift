//
//  NewsView.swift
//  HackerNews
//
//  Created by Matteo Manferdini on 15/10/2020.
//

import SwiftUI

struct NewsView: View {
	@State private var model = ViewModel()

	var body: some View {
		List(model.stories) { story in
			Entry(story: story)
		}
		.listStyle(.plain)
		.navigationTitle("News")
		.task {
			try? await model.fetchTopStories()
		}
	}
}

extension Entry {
	init(story: Item) {
		title = story.title
		score = story.score
		commentCount = story.commentCount
		footnote = (story.url.host() ?? "")
		+ " - \(story.date.formatted(.relative(presentation: .numeric)))"
		+ " - by \(story.author)"
	}
}

#Preview {
	NavigationStack {
		NewsView()
	}
}
