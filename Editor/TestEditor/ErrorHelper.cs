﻿using System.Diagnostics.CodeAnalysis;

namespace TestEditor
{
	public static class ErrorHelper
	{
		[DoesNotReturn]
		public static void RaiseMissingArgumentError(in string paramname) => throw new ArgumentNullException(paramname);
	}
}
