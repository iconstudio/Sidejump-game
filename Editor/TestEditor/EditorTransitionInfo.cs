namespace TestEditor
{
	internal enum EditorTransitionCategory
	{
		Home, Create, Load, Exit
	}

	[Serializable]
	internal readonly struct EditorTransitionInfo
	{
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
