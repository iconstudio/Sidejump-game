using System.Runtime.Serialization;

namespace TestEditor
{
	[Serializable]
	internal class Singleton<T> where T : class, IComparable, IComparable<T>
	{
		public static T Instance;

		public Singleton(T instance)
		{
			if (Instance is not null)
			{
				throw new SingletonException($"Duplicated instance of { nameof(T) }");
			}

			Instance = instance;
		}

		public static T GetInstance() => Instance;
	}

	[Serializable]
	class SingletonException : ApplicationException
	{
		public SingletonException() : base()
		{ }
		public SingletonException(string message) : base(message)
		{ }
	}
}
