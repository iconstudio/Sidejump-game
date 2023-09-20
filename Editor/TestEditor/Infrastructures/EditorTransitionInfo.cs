namespace TestEditor
{
	internal enum EditorTransitionCategory
	{
		Home, Create, Load, Exit
	}

	[Serializable]
	internal readonly struct EditorTransitionInfo
	{
		public static readonly EditorTransitionInfo homeTransition;
		public static readonly EditorTransitionInfo saveTransition;
		public static readonly EditorTransitionInfo loadTransition;
		public static readonly EditorTransitionInfo exitTransition;

		static EditorTransitionInfo()
		{
			homeTransition = new EditorTransitionInfo(EditorTransitionCategory.Home);
			saveTransition = new EditorTransitionInfo(EditorTransitionCategory.Create);
			loadTransition = new EditorTransitionInfo(EditorTransitionCategory.Load);
			exitTransition = new EditorTransitionInfo(EditorTransitionCategory.Exit);
		}
		public EditorTransitionInfo()
		{
			transitionCategory = EditorTransitionCategory.Home;
		}
		public EditorTransitionInfo(EditorTransitionCategory category)
		{
			transitionCategory = category;
		}

		public readonly EditorTransitionCategory transitionCategory;
	}
}
