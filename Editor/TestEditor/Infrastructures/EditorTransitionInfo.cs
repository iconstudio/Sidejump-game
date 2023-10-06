using System.Diagnostics.Contracts;

namespace TestEditor
{
	public enum EditorTransitionCategory
	{
		Home, Create, Load, Exit
	}

	[Serializable]
	public readonly struct EditorTransitionInfo : IEquatable<EditorTransitionInfo>
	{
		public static readonly EditorTransitionInfo homeTransition;
		public static readonly EditorTransitionInfo saveTransition;
		public static readonly EditorTransitionInfo loadTransition;
		public static readonly EditorTransitionInfo exitTransition;

		public readonly EditorTransitionCategory TransitionCategory { get; }

		static EditorTransitionInfo()
		{
			homeTransition = new(EditorTransitionCategory.Home);
			saveTransition = new(EditorTransitionCategory.Create);
			loadTransition = new(EditorTransitionCategory.Load);
			exitTransition = new(EditorTransitionCategory.Exit);
		}
		public EditorTransitionInfo() : this(EditorTransitionCategory.Home)
		{ }
		public EditorTransitionInfo(EditorTransitionCategory category)
		{
			TransitionCategory = category;
		}

		[Pure]
		public readonly bool Equals(EditorTransitionInfo other)
		{
			return other.TransitionCategory == TransitionCategory;
		}
		[Pure]
		public override readonly bool Equals(object obj)
		{
			return obj is EditorTransitionInfo other && Equals(other);
		}
		[Pure]
		public override readonly int GetHashCode()
		{
			return TransitionCategory.GetHashCode();
		}

		[Pure]
		public static bool operator ==(in EditorTransitionInfo left, in EditorTransitionInfo right)
		{
			return left.Equals(right);
		}
		[Pure]
		public static bool operator !=(in EditorTransitionInfo left, in EditorTransitionInfo right)
		{
			return !(left == right);
		}
	}
}
