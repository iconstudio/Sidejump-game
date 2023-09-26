using System.Collections;
using System.Diagnostics.CodeAnalysis;
using System.Diagnostics.Contracts;

namespace TestEditor.WinUI
{
	internal class ChildWindowCollection
		: IList<ChildWindow>, IReadOnlyList<ChildWindow>
		, IReadOnlyCollection<ChildWindow>
	{
		private List<ChildWindow> myChildren = new();
		public int Count => myChildren.Count;
		public bool IsReadOnly => false;

		public ChildWindow this[int index]
		{
			get => myChildren[index];
			set => myChildren[index] = value;
		}
		ChildWindow IReadOnlyList<ChildWindow>.this[int index] => ((IReadOnlyList<ChildWindow>) myChildren)[index];

		public WindowProjection Emplace(ChildWindow item)
		{
			myChildren.Add(item);

			return item.Projection;
		}
		public WindowProjection Emplace(in ChildWindow item)
		{
			myChildren.Add(item);

			return item.Projection;
		}
		public WindowProjection Emplace([NotNull] in Window window)
		{
			return Emplace(new ChildWindow(window, new(window)));
		}
		void ICollection<ChildWindow>.Add(ChildWindow item)
		{
			Emplace(item);
		}
		void IList<ChildWindow>.Insert(int index, ChildWindow item)
		{
			myChildren.Insert(index, item);
		}

		int IList<ChildWindow>.IndexOf(ChildWindow item)
		{
			return myChildren.IndexOf(item);
		}
		public void CopyTo(ChildWindow[] array, int arrayIndex)
		{
			myChildren.CopyTo(array, arrayIndex);
		}
		public IEnumerator<ChildWindow> GetEnumerator()
		{
			return ((IEnumerable<ChildWindow>) myChildren).GetEnumerator();
		}
		IEnumerator IEnumerable.GetEnumerator()
		{
			return ((IEnumerable) myChildren).GetEnumerator();
		}

		bool ICollection<ChildWindow>.Remove(ChildWindow item)
		{
			return myChildren.Remove(item);
		}
		public void RemoveAt(int index)
		{
			myChildren.RemoveAt(index);
		}
		public void Clear()
		{
			myChildren.Clear();
		}

		[Pure]
		bool ICollection<ChildWindow>.Contains(ChildWindow item)
		{
			return myChildren.Contains(item);
		}
	}
}
