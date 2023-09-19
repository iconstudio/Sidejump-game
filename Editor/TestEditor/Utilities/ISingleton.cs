namespace TestEditor.Utility
{
    internal interface ISingleton<T> where T : class
    {
        private static T _Instance;

        public static T Instance
        {
            get => _Instance;

            internal set => SetInstance(value);
        }

        public static void SetInstance(T instance)
        {
            if (_Instance is not null)
            {
                throw new SingletonException($"Duplicated instance of {nameof(T)}");
            }

            _Instance = instance;
        }
        public static bool TryInstance(T instance)
        {
            if (_Instance is not null)
            {
                return false;
            }

            _Instance = instance;
            return true;
        }
        public static T GetInstance()
        {
            lock (Instance)
            {
                return Instance;
            }
        }
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
